//
//  Translate.swift
//  travelApp
//
//  Created by Loranne Joncheray on 12/09/2022.
//

import Foundation

class TranslateService {
    static var shared = TranslateService()
    private init() {}
    
    // Task for the request
    private var task: URLSessionDataTask?
    
    let session = URLSession(configuration: .default)
    
    private let translateUrl = "https://api-free.deepl.com/v2/translate"
    private let apiKey = "d0d758bf-623c-d2ce-11a4-f9830006bbe2:fx"
    
    private func createUrlRequest(text: String) -> URLRequest? {
        guard let escapedString = text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return nil }
        let finalRequest = "\(translateUrl)?auth_key=\(apiKey)&text=\(escapedString)&target_lang=en"
        var request = URLRequest(url: URL(string: finalRequest)!)
        request.httpMethod = "POST"
        return request
    }
        
    func getTranslation(text: String, callback: @escaping (Bool, TranslateData?) -> Void) {
        guard let request = createUrlRequest(text: text) else {
            callback(false, nil)
            return
        }
        
        task?.cancel()
        task = session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil,
                      let response = response as? HTTPURLResponse, response.statusCode == 200,
                      let responseJSON = try? JSONDecoder().decode(TranslateData.self, from: data) else {
                    callback(false, nil)
                    return
                }
                callback(true, responseJSON)
            }
        }
        task?.resume()
    }
}
