//
//  FakeResponseDatas.swift
//  travelAppTests
//
//  Created by Loranne Joncheray on 12/10/2022.
//

import Foundation

class FakeResponseData {
    
    // Response
    static let responseOk = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!,
                                            statusCode: 200, httpVersion: nil, headerFields: nil)
    
    static let reponseKO = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!,
                                           statusCode: 400, httpVersion: nil, headerFields: nil)
    
    // Error
    class ExchangeError: Error {}
    static let errorExchange = ExchangeError()
    
    class WeatherError: Error {}
    static let errorWeather = WeatherError()
    
    class TranslateError: Error {}
    static let errorTranslate = TranslateError()
    
    // Data
    
    // Exchange
    static var exchangeCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Exchange", withExtension: "json")
        guard let data = try? Data(contentsOf: url!) else {
            fatalError("Exchange.json can't be loaded")
        }
        return data
    }
    
    // Weather
    static var weatherCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Weather", withExtension: "json")
        guard let data = try? Data(contentsOf: url!) else {
            fatalError("Weather.json can't be loaded")
        }
        return data
    }
    
    // Translate
    static var translateCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Translate", withExtension: "json")
        guard let data = try? Data(contentsOf: url!) else {
            fatalError("Translate.json can't be loaded")
        }
        return data
    }
    
    // Incorrect Data
    static let exchangeIncorrectData = "error".data(using: .utf8)!
    
    static let weatherIncorrectData = "error".data(using: .utf8)!
    
    static let translateIncorrectData = "error".data(using: .utf8)!
}
