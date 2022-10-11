//
//  File.swift
//  travelApp
//
//  Created by Loranne Joncheray on 20/09/2022.
//

import Foundation

// Struct weatherData
struct WeatherData: Decodable {
    let list: [CurrentLocalWeather]
}

// CurrentLocalWeather
struct CurrentLocalWeather: Decodable {
    let weather: [Weather]
    let main: Main
}

// Main
struct Main: Decodable {
    let temp: Double
}

// Weather
struct Weather: Decodable {
    let description: String
    let icon: String
}
