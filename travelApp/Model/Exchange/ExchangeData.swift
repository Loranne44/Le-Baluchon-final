//
//  Currency.swift
//  travelApp
//
//  Created by Loranne Joncheray on 13/09/2022.
//

import Foundation

struct ExchangeData: Decodable {
    let date: String
    let rates : [String: Double]
}
