//
//  Cookie.swift
//  MeatCrush
//
//  Created by Ryan Dines on 8/10/17.
//  Copyright © 2017 Ryan Dines. All rights reserved.
//

import SpriteKit

enum CookieType: Int {
    case unknown = 0, croissant, bacon, danish, donut, macaroon, mustard
    var spriteName: String {
        let spriteNames = [
            "Turkey",
            "Bacon",
            "Cheese",
            "Pastrami",
            "BoarsHead",
            "Mustard"]
        
        return spriteNames[rawValue - 1]
    }
    var description: String {
        return spriteName
    }
    var highlightedSpriteName: String {
        return spriteName + "-Highlighted"
    }
    static func random() -> CookieType {
        return CookieType(rawValue: Int(arc4random_uniform(6)) + 1)!
    }
}

class Cookie {
    var column: Int
    var row: Int
    let cookieType: CookieType
    var sprite: SKSpriteNode?
    
    init(column: Int, row: Int, cookieType: CookieType) {
        self.column = column
        self.row = row
        self.cookieType = cookieType
    }
}
extension Cookie: CustomStringConvertible {
    var description: String {
        return "type:\(cookieType) square:(\(column),\(row))"
    }
}
extension Cookie: Hashable {
    var hashValue: Int {
        return row*10 + column
    }
    static func ==(lhs: Cookie, rhs: Cookie) -> Bool {
        return lhs.column == rhs.column && lhs.row == rhs.row
    }
}
