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
    
    private let translateUrl = "https://api-free.deepl.com/v2/translate"
    private let apiKey = "63b25206-d852-dbf0-135e-01e1b36b9af3:fx"
    
    // Task for the request
    private var task: URLSessionDataTask?
    private var translateSession = URLSession(configuration: .default)
    
    init(translateSession: URLSession) {
        self.translateSession = translateSession
    }
    
    // URL & Request configuration
    private func createUrlRequest(text: String) -> URLRequest? {
        guard let escapedString = text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return nil }
        let rawUrl = "\(translateUrl)?auth_key=\(apiKey)&text=\(escapedString)&target_lang=en"
        guard let url = URL(string: rawUrl) else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        return request
    }
     
    // Recovery and processing of translation
    func getTranslation(text: String, callback: @escaping (TranslateDataError?, TranslateData?) -> Void) {
        guard let request = createUrlRequest(text: text) else {
            callback(.errorApiKey, nil)
            return
        }

        task?.cancel()
        task = translateSession.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data,
                      error == nil,
                      let response = response as? HTTPURLResponse,
                      response.statusCode == 200,
                      let responseJSON = try? JSONDecoder().decode(TranslateData.self, from: data) else {
                    callback(.invalidResponse, nil)
                    return
                }
                callback(.none, responseJSON)
            }
        }
        task?.resume()
    }
}
