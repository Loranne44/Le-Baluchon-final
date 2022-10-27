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
    
    // URL & Request configuration
    private func createUrlWithKey() -> URLRequest? {
        let url = "\(exchangeCurrencyUrl)&symbols=USD,BTC"
        
        
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        request.addValue("Vtagy2z1zp79DO0hNjWEhVTsW8Uwc6uV", forHTTPHeaderField: "apikey")
        return request
    }
    
    // Rate recovery and processing
    func getExchangeCurrency(date: Date = .now, callback: @escaping (ExchangeDataError?, ExchangeData?) -> Void) {
        
        var dateOfDay: String {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter.string(from: date)
        }
    
        guard let request = createUrlWithKey()  else {
            callback(.errorApiKey, nil)
            return
        }
        
        task?.cancel()
        task = exchangeSession.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                
                guard let data = data,
                      error == nil,
                      let response = response as? HTTPURLResponse,
                      response.statusCode == 200,
                      let responseJSON = try? JSONDecoder().decode(ExchangeData.self, from: data) else {
                    callback(.invalidResponse, nil)
                    return
                }
                // Verification that the date is the same as today's
                // guard a la place du if else
               if responseJSON.date == dateOfDay {
                    callback(.none, responseJSON)
                } else {
                    callback(.invalidDate, nil)
                }
            }
        }
        task?.resume()
    }
    
    // Data conversion
    func convertCurrencies(
        dataCurrencieTarget: ExchangeData,
        currencieKey: String,
        euroValue: Double
    )-> String {
        guard let valueToConvert = dataCurrencieTarget.rates[currencieKey] else {
            return ""
        }
        let convertCurrency = euroValue * valueToConvert
        let StringConvertCurrency = String(format: "%.5f", convertCurrency)
        
        return StringConvertCurrency
    }
}
