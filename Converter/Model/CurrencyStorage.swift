//
//  CurrencyStorage.swift
//  Converter
//
//  Created by Elie Arquier on 01/02/2021.
//

import Foundation

/// Store the values ​​obtained by decoding the Json file.
struct CurrencyStorage {
    /// List displayed in TableView uses for currenciesList key
    static var currenciesKeys: [String] = []

    /// Dictionnary that makes the link between currenciesKey and currencis. currenciesList value will be used as currencies key
    static var currenciesList: [String: String] = [:]

    /// Dictionary where are stored exchange rates
    static var currencies: [String: Double] = [:]
}
