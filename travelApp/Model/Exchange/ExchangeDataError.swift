//
//  ExchangeDataError.swift
//  travelApp
//
//  Created by Loranne Joncheray on 06/10/2022.
//

import Foundation

enum ExchangeDataError: Error {
    case invalidDate
    case invalideResponse
    case rateNotFound
    case invalidInput
}
