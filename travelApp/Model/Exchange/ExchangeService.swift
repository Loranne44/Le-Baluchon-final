//
//  Exchange.swift
//  travelApp
//
//  Created by Loranne Joncheray on 12/09/2022.
//

import Foundation
import UIKit


class ExchangeService {
    static var shared = ExchangeService()
    private init() {}
    
    //URL
    private let exchangeCurrencyUrl = "https://api.apilayer.com/fixer/latest"
    
    // Task for the request
    private var task: URLSessionDataTask?
    
    let session = URLSession(configuration: .default)
        
    // URL + KEY
    private func createUrlWithKey() -> URLRequest? {
        let url = "\(exchangeCurrencyUrl)&symbols=USD,BTC"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        request.addValue("Vtagy2z1zp79DO0hNjWEhVTsW8Uwc6uV", forHTTPHeaderField: "apikey")
        return request
    }
    
    // Récuperer la réponse du changement de devise
    func getExchangeCurrency(callback: @escaping (Bool, ExchangeData?) -> Void) {
        guard let request = createUrlWithKey()  else {
            callback(false, nil)
            return
        }
        
        task?.cancel()
        task = session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                //breakpoint
                guard let data = data, error == nil,
                      let response = response as? HTTPURLResponse, response.statusCode == 200,
                      let responseJSON = try? JSONDecoder().decode(ExchangeData.self, from: data) else {
                    callback(false, nil)
                    return
                }
                callback(true, responseJSON)
            }
        }
        task?.resume()
    }
    
    func convertCurrencies(currencie: ExchangeData, valueToConvert: String, ratesLabelCurrencie: UILabel, ratesLabelEur: UITextField ) -> String {
        guard let eur = ratesLabelEur.text,
              let doubleEur = Double(eur),
              let valueToConvert = currencie.rates[valueToConvert] else {
            return ""
        }
        let convertCurrency = doubleEur * valueToConvert
        let StringConvertCurrency = String(format: "%.5f", convertCurrency)
        
        return StringConvertCurrency
    }
}
