//
//  CurrencyDecodable.swift
//  Converter
//
//  Created by Elie Arquier on 01/02/2021.
//

import Foundation

/// Decoding structure of the response Json file: exchange rates network call
struct  Currency: Decodable {
    var rates: [String: Double]
}

/// Decoding structure of the response Json file: currencies name network call
struct CurrencyList: Decodable {
    var symbols: [String: String]
}
