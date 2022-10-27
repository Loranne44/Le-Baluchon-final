//
//  WeatherDataErr.swift
//  travelApp
//
//  Created by Loranne Joncheray on 12/10/2022.
//

import Foundation

enum WeatherDataError: Error {
    case countUpdatedCities
    case invalidResponse
    case errorApiKey
    
    var message : String {
        switch self {
        case .countUpdatedCities :
            return "Updated city account error for weather"
        case .invalidResponse :
            return "Error in response Api"
        case .errorApiKey :
            return "Error in apy key"
        }
    }
}

// A modifier dans le controller
