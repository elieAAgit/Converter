//
//  ApiService.swift
//  Converter
//
//  Created by Elie Arquier on 01/02/2021.
//

import Foundation

final class ApiService {
    // Singleton pattern
    static var shared = ApiService()
    init() {}

    private var task: URLSessionDataTask?
    private var session = URLSession(configuration: .default)

    init(session: URLSession) {
        self.session = session
    }

    // API request
    func getApiResponse(apiUrl: ApiUrl, callback: @escaping (Bool, Any?) -> Void) {
        let urlChoice = apichoice(apiUrl: apiUrl)
        let request = getRequest(UrlChoice: urlChoice)

        task?.cancel()
        task = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }

                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }

                self.responseJson(apiUrl: apiUrl, response: response, callback: callback, data: data)
            }
        }

        task?.resume()
    }

    /// Choice of service call
    private func apichoice(apiUrl: ApiUrl) -> String {
        var apiChoice = String()

        switch apiUrl {
        case .currencyUrl:
            apiChoice = ApiKeys.currencyUrl
        case .currencyListUrl:
            apiChoice = ApiKeys.currencyListUrl
        }

        return apiChoice
    }

    ///URLRequest
    private func getRequest(UrlChoice: String) -> URLRequest {
        let requestUrl = URL(string: UrlChoice)!
        var request = URLRequest(url: requestUrl)

        let method = "POST"

        request.httpMethod = method

        return request
    }

    /// Call response
    private func responseJson(apiUrl: ApiUrl, response: HTTPURLResponse, callback: @escaping (Bool, Any?) -> Void, data: Data ) {

        //Currency
        if apiUrl == ApiUrl.currencyUrl {
            guard let responseJSON = try? JSONDecoder().decode(Currency.self, from: data) else {
                callback(false, nil)
                return
            }

            CurrencyStorage.currencies = responseJSON.rates
            callback(true, nil)

        //Currency list
        } else if apiUrl == ApiUrl.currencyListUrl {
            guard let responseJSON = try? JSONDecoder().decode(CurrencyList.self, from: data) else {
                callback(false, nil)
                return
            }

            for (key, value) in Array(responseJSON.symbols.sorted(by: {$0.0 < $1.0})) {
                CurrencyStorage.currenciesKeys.append(value)
                //
                CurrencyStorage.currenciesList[value] = key
            }
            callback(true, nil)
        }
    }
}
