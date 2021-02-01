//
//  ApiKeysAccess.swift
//  Converter
//
//  Created by Elie Arquier on 01/02/2021.
//

import Foundation

///Call keys in plist file
func valueForAPIKey(named keyname: String) -> String {
    let filePath = Bundle.main.path(forResource: "APIKeys", ofType: "plist")
    let plist = NSDictionary(contentsOfFile:filePath!)
    let value = plist?.object(forKey: keyname) as! String
    return value
}
