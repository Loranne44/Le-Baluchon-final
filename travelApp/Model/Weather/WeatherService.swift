//
//  Weather.swift
//  travelApp
//
//  Created by Loranne Joncheray on 12/09/2022.
//

import Foundation

class WeatherService {
    // Task for the request
    private var task: URLSessionDataTask?
    let session = URLSession(configuration: .default)
    
    static var shared = WeatherService()
    private init() {}
    
    private let url = "https://api.openweathermap.org/data/2.5/group"
    private let idNantes = "2990969"
    private let idNYC = "5125771"
    private let apiKey = "334cb77f2729f993f4f58b192bbd5e23"
    
    private func createUrlRequest() -> URLRequest? {
        let finalRequest = "\(url)?id=\(idNantes),\(idNYC)&appid=\(apiKey)&lang=en&units=metric"
        var request = URLRequest(url: URL(string: finalRequest)!)
        request.httpMethod = "POST"
        return request
    }
    
    func getWeather(callback: @escaping (Bool, WeatherData?) -> Void) {
        guard let request = createUrlRequest() else {
            callback(false, nil)
            return
        }
        
        task?.cancel()
        task = session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil,
                      let response = response as? HTTPURLResponse, response.statusCode == 200,
                      let responseJSON = try? JSONDecoder().decode(WeatherData.self, from: data) else {
                    callback(false, nil)
                    return
                }
                callback(true, responseJSON)
            }
        }
        task?.resume()
    }
}
