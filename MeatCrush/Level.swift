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
    
    init(filename: String) {
        // 1
        guard let dictionary = Dictionary<String, AnyObject>.loadJSONFromBundle(filename: filename) else { return }
        // 2
        guard let tilesArray = dictionary["tiles"] as? [[Int]] else { return }
        // 3
        for (row, rowArray) in tilesArray.enumerated() {
            // 4
            let tileRow = NumRows - row - 1
            // 5
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
        return createInitialCookies()
    }
    
    private func createInitialCookies() -> Set<Cookie> {
        var set = Set<Cookie>()
        
        // 1
        
        for row in 0..<NumRows {
            for column in 0..<NumColumns {
                //print("Cookies: \(cookies)")
                print("Tiles: \(tiles)")
                
                 if tiles[column, row] != nil {
                    // 2
                
                    let cookieType = CookieType.random()
                    
                    // 3
                    let cookie = Cookie(column: column, row: row, cookieType: cookieType)
                    cookies[column, row] = cookie
                    
                    // 4
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
}
