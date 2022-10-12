//
//  ExchangerEr.swift
//  travelApp
//
//  Created by Loranne Joncheray on 07/10/2022.
//

import Foundation

enum ExchangeDataError: Error {
    case invalidDate
    case invalideResponse
    case invalidAmount
    case invalideData
    case errorApiKey
}
