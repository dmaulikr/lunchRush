//
//  Level.swift
//  MeatCrush
//
//  Created by Ryan Dines on 8/10/17.
//  Copyright © 2017 Ryan Dines. All rights reserved.
//

import Foundation

let NumColumns = 9
let NumRows = 9

class Level {
    
    private var possibleSwaps = Set<Swap>()
    
    init(filename: String) {
        guard let dictionary = Dictionary<String, AnyObject>.loadJSONFromBundle(filename: filename) else { return }
        guard let tilesArray = dictionary["tiles"] as? [[Int]] else { return }
        for (row, rowArray) in tilesArray.enumerated() {
            let tileRow = NumRows - row - 1
            for (column, value) in rowArray.enumerated() {
                if value == 1 {
                    tiles[column, tileRow] = Tile()
                }
            }
        }
    }
    
    fileprivate var cookies = Array2D<Cookie>(columns: NumColumns, rows: NumRows)
    private var tiles = Array2D<Tile>(columns: NumColumns, rows: NumRows)

    func cookieAt(column: Int, row: Int) -> Cookie? {
        assert(column >= 0 && column < NumColumns)
        assert(row >= 0 && row < NumRows)
        return cookies[column, row]
    }
    func shuffle() -> Set<Cookie> {
        var set: Set<Cookie>
        repeat {
            set = createInitialCookies()
            detectPossibleSwaps()
            print("possible swaps: \(possibleSwaps)")
        } while possibleSwaps.count == 0
        
        return set
    }
    func isPossibleSwap(_ swap: Swap) -> Bool {
        return possibleSwaps.contains(swap)
    }
    func detectPossibleSwaps() {
        var set = Set<Swap>()
        
        for row in 0..<NumRows {
            for column in 0..<NumColumns {
                if let cookie = cookies[column, row] {
                    // Is it possible to swap this cookie with the one on the right?
                    if column < NumColumns - 1 {
                        // Have a cookie in this spot? If there is no tile, there is no cookie.
                        if let other = cookies[column + 1, row] {
                            // Swap them
                            cookies[column, row] = other
                            cookies[column + 1, row] = cookie
                            
                            // Is either cookie now part of a chain?
                            if hasChainAt(column: column + 1, row: row) ||
                                hasChainAt(column: column, row: row) {
                                set.insert(Swap(cookieA: cookie, cookieB: other))
                            }
                            
                            // Swap them back
                            cookies[column, row] = cookie
                            cookies[column + 1, row] = other
                        }
                    }
                    if row < NumRows - 1 {
                        if let other = cookies[column, row + 1] {
                            cookies[column, row] = other
                            cookies[column, row + 1] = cookie
                            
                            // Is either cookie now part of a chain?
                            if hasChainAt(column: column, row: row + 1) ||
                                hasChainAt(column: column, row: row) {
                                set.insert(Swap(cookieA: cookie, cookieB: other))
                            }
                            
                            // Swap them back
                            cookies[column, row] = cookie
                            cookies[column, row + 1] = other
                        }
                    }
                }
            }
        }
        
        possibleSwaps = set
    }
    private func hasChainAt(column: Int, row: Int) -> Bool {
        let cookieType = cookies[column, row]!.cookieType
        
        // Horizontal chain check
        var horzLength = 1
        
        // Left
        var i = column - 1
        while i >= 0 && cookies[i, row]?.cookieType == cookieType {
            i -= 1
            horzLength += 1
        }
        
        // Right
        i = column + 1
        while i < NumColumns && cookies[i, row]?.cookieType == cookieType {
            i += 1
            horzLength += 1
        }
        if horzLength >= 3 { return true }
        
        // Vertical chain check
        var vertLength = 1
        
        // Down
        i = row - 1
        while i >= 0 && cookies[column, i]?.cookieType == cookieType {
            i -= 1
            vertLength += 1
        }
        
        // Up
        i = row + 1
        while i < NumRows && cookies[column, i]?.cookieType == cookieType {
            i += 1
            vertLength += 1
        }
        return vertLength >= 3
    }
    
    private func createInitialCookies() -> Set<Cookie> {
        var set = Set<Cookie>()
        for row in 0..<NumRows {
            for column in 0..<NumColumns {
                 if tiles[column, row] != nil {
                    var cookieType: CookieType
                    repeat {
                        cookieType = CookieType.random()
                    } while (column >= 2 && // don't check column 0 or 1
                        cookies[column - 1, row]?.cookieType == cookieType
                        && cookies[column - 2, row]?.cookieType == cookieType) ||  // two left cookies can't match
                        (row >= 2 &&  // don't check row 0 or 1
                        cookies[column, row - 1]?.cookieType == cookieType &&
                        cookies[column, row - 2]?.cookieType == cookieType)  // two down cookies can't match
                    let cookie = Cookie(column: column, row: row, cookieType: cookieType)
                    cookies[column, row] = cookie
                    set.insert(cookie)
                 }
            }
        }
        return set
    }
    
    func tileAt(column: Int, row: Int) -> Tile? {
        assert(column >= 0 && column < NumColumns)
        assert(row >= 0 && row < NumRows)
        return tiles[column, row]
    }
    func performSwap(swap: Swap) {
        let columnA = swap.cookieA.column
        let rowA = swap.cookieA.row
        let columnB = swap.cookieB.column
        let rowB = swap.cookieB.row
        
        cookies[columnA, rowA] = swap.cookieB
        swap.cookieB.column = columnA
        swap.cookieB.row = rowA
        
        cookies[columnB, rowB] = swap.cookieA
        swap.cookieA.column = columnB
        swap.cookieA.row = rowB
    }
}
