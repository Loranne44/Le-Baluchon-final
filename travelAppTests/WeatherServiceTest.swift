//
//  WeatherServiceTests.swift
//  travelAppTests
//
//  Created by Loranne Joncheray on 12/10/2022.
//

@testable import travelApp
import XCTest


final class WeatherServiceTest: XCTestCase {

    // si jai une erreur
    func testGetExchangeCurrencyShouldPostFailedCallBackIfError() {
        // Given
        let weatherService = WeatherService(weatherSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.errorWeather))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        weatherService.getWeather { weatherDataError, weather in
            // Then
            XCTAssertEqual(weatherDataError, .invalideResponse)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // pas de data recu avec l'appel
    func testGetExchangeCurrencyShouldPostFailedCallBackIfNoData() {
        // Given
        let weatherService = WeatherService(weatherSession: URLSessionFake(data: nil, response: nil, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        weatherService.getWeather { weatherDataError, weather in
            // Then
            XCTAssertEqual(weatherDataError, .invalideResponse)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // donnée correct mais reponse pas correct
    func testGetExchangeCurrencyShouldPostFailedCallBackIfIncorrectResponse() {
        // Given
        let weatherService = WeatherService(weatherSession: URLSessionFake(data: FakeResponseData.weatherCorrectData , response: FakeResponseData.reponseKO, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        weatherService.getWeather { weatherDataError, weather in
            // Then
            XCTAssertEqual(weatherDataError, .invalideResponse)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // donnée incorrect mais réponse correct
    func testGetExchangeCurrencyShouldPostFailedCallBackIfIncorrectData() {
        // Given
        let weatherService = WeatherService(weatherSession: URLSessionFake(data: FakeResponseData.weatherIncorrectData , response: FakeResponseData.responseOk, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        weatherService.getWeather { weatherDataError, weather in
            // Then
            XCTAssertEqual(weatherDataError, .invalideResponse)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // Tout ok
    func testGetExchangeCurrencyShouldPostSuccessCallBackIfNoErrorAndCorrectData() {
        // Given
        let weatherService = WeatherService(weatherSession: URLSessionFake(data: FakeResponseData.weatherCorrectData , response: FakeResponseData.responseOk, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        weatherService.getWeather { weatherDataError, weather in
            // Then
            XCTAssertEqual(weatherDataError, .none)
            XCTAssertNotNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}

