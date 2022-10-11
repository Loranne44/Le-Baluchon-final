//
//  TranslateData.swift
//  travelApp
//
//  Created by Loranne Joncheray on 23/09/2022.
//

import Foundation

struct TranslateData: Decodable {
    let translations: [Translation]
}

struct Translation: Decodable {
    let detected_source_language: String
    let text: String
}
