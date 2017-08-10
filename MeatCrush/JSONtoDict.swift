//
//  JSONtoDict.swift
//  MeatCrush
//
//  Created by Ryan Dines on 8/10/17.
//  Copyright © 2017 Ryan Dines. All rights reserved.
//

import Foundation

extension Dictionary {
    static func loadJSONFromBundle(filename: String) -> Dictionary<String, AnyObject>? {
        var dataOK: Data
        var dictionaryOK: NSDictionary = NSDictionary()
        print("Resource filename: \(filename)")
        if let path = Bundle.main.path(forResource: "Levels/" + filename, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: NSData.ReadingOptions()) as Data!
                dataOK = data!
            }
            catch {
                print("Could not load level file: \(filename), error: \(error)")
                return nil
            }
            do {
                let dictionary = try JSONSerialization.jsonObject(with: dataOK, options: JSONSerialization.ReadingOptions()) as AnyObject!
                dictionaryOK = (dictionary as! NSDictionary as? Dictionary<String, AnyObject>)! as NSDictionary
            }
            catch {
                print("Level file '\(filename)' is not valid JSON: \(error)")
                return nil
            }
        }else{
            print("Could not find filepath")
        }
        return dictionaryOK as? Dictionary<String, AnyObject>
    }
}
