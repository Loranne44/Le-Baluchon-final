//
//  TranslateDataErr.swift
//  travelApp
//
//  Created by Loranne Joncheray on 12/10/2022.
//

import Foundation

enum TranslateDataError: Error {
    
    case invalidResponse
    case errorApiKey
    
    var message: String {
        switch self {
        case .invalidResponse:
            return "Error in response Api"
        case .errorApiKey:
            return "Error in apy key"
        }
    }
}
