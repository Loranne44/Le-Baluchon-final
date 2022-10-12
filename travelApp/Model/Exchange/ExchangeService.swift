//
//  Exchange.swift
//  travelApp
//
//  Created by Loranne Joncheray on 12/09/2022.
//

import Foundation


class ExchangeService {
    static var shared = ExchangeService()
    private init() {}
    
    //URL
    private let exchangeCurrencyUrl = "https://api.apilayer.com/fixer/latest"
    
    // Task for the request
    private var task: URLSessionDataTask?
    private var exchangeSession = URLSession(configuration: .default)
    
    init(exchangeSession: URLSession) {
        self.exchangeSession = exchangeSession
    }
    
    // URL + KEY
    private func createUrlWithKey() -> URLRequest? {
        let url = "\(exchangeCurrencyUrl)&symbols=USD,BTC"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        request.addValue("Vtagy2z1zp79DO0hNjWEhVTsW8Uwc6uV", forHTTPHeaderField: "apikey")
        return request
    }
    
    // Récuperer la réponse du changement de devise
    func getExchangeCurrency(callback: @escaping (ExchangeDataError?, ExchangeData?) -> Void) {
        guard let request = createUrlWithKey()  else {
            callback(.errorApiKey, nil)
            return
        }
        
        task?.cancel()
        task = exchangeSession.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                
                guard let data = data, error == nil,
                      let response = response as? HTTPURLResponse, response.statusCode == 200,
                      let responseJSON = try? JSONDecoder().decode(ExchangeData.self, from: data) else {
                    callback(.invalideResponse, nil)
                    return
                }
                callback(.none, responseJSON)
            }
        }
        task?.resume()
    }
    
    func convertCurrencies(
        dataCurrencieTarget: ExchangeData,
        currencieKey: String,
        euroValue: Double
    )-> String {
        guard
            
            let valueToConvert = dataCurrencieTarget.rates[currencieKey] else {
            return ""
        }
        let convertCurrency = euroValue * valueToConvert
        let StringConvertCurrency = String(format: "%.5f", convertCurrency)
        
        return StringConvertCurrency
    }
}
