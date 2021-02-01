//
//  ApiKeys.swift
//  Converter
//
//  Created by Elie Arquier on 01/02/2021.
//

import Foundation

/// Different network call cases that can be made
enum ApiUrl {
    case currencyUrl, currencyListUrl
}

// MARK: - Currencies
struct ApiKeys {
    static private let currencyBase = "http://data.fixer.io/api/"
    static private let currencyChange = "latest"
    static private let currencySymbols = "symbols"
    static private let currencyKey = valueForAPIKey(named:"CurrencyKey")

    // Exchange rates
    static var currencyUrl: String {
        return currencyBase + currencyChange + currencyKey
    }

    // Currencies list
    static var currencyListUrl: String {
        return currencyBase + currencySymbols + currencyKey
    }
}
