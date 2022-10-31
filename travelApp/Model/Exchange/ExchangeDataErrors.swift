//
//  ExchangerEr.swift
//  travelApp
//
//  Created by Loranne Joncheray on 07/10/2022.
//

import Foundation

enum ExchangeDataError: Error {
    case invalidDate
    case invalidResponse
    case invalidAmount
    case invalidData
    case errorApiKey
    
    var message : String {
        switch self {
        case .invalidDate:
            return "Error date download"
        case .invalidResponse:
            return "Error in response Api"
        case .invalidData:
            return "Rates data download failed"
        case .invalidAmount:
            return "Enter a valid amount"
        case .errorApiKey:
            return "Error in apy key"
        }
    }
}
