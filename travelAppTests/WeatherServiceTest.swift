//
//  WeatherServiceTests.swift
//  travelAppTests
//
//  Created by Loranne Joncheray on 12/10/2022.
//

@testable import travelApp
import XCTest

final class WeatherServiceTest: XCTestCase {
    
    func testWeatherShouldPostFailedCallBackIfError() {
        // Given
        URLProtocolStub.loadingHandler = { request in
            let response : HTTPURLResponse = FakeResponseData.responseOk!
            let error : Error? = FakeResponseData.errorWeather
            let data: Data? = nil
            return(response, data, error)
        }
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolStub.self]
        let session = URLSession(configuration: configuration)
        let weatherService = WeatherService(weatherSession: session)
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather { weatherDataError, weather in
            // Then
            XCTAssertEqual(weatherDataError, .invalidResponse)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testWeatherShouldPostFailedCallBackIfNoData() {
        // Given
        URLProtocolStub.loadingHandler = { request in
            let response : HTTPURLResponse = FakeResponseData.responseOk!
            let error : Error? = nil
            let data: Data? = nil
            return(response, data, error)
        }
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolStub.self]
        let session = URLSession(configuration: configuration)
        let weatherService = WeatherService(weatherSession: session)
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather { weatherDataError, weather in
            // Then
            XCTAssertEqual(weatherDataError, .invalidResponse)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.02)
    }
    
    func testWeatherShouldPostFailedCallBackIfIncorrectResponse() {
        // Given
        URLProtocolStub.loadingHandler = { request in
            let response : HTTPURLResponse = FakeResponseData.responseOk!
            let error : Error? = nil
            let data: Data? = nil
            return(response, data, error)
        }
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolStub.self]
        let session = URLSession(configuration: configuration)
        let weatherService = WeatherService(weatherSession: session)
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather { weatherDataError, weather in
            // Then
            XCTAssertEqual(weatherDataError, .invalidResponse)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testWeatherShouldPostSuccessCallBackIfNoErrorAndCorrectData() {
        // Given
        URLProtocolStub.loadingHandler = { request in
            let response : HTTPURLResponse = FakeResponseData.responseOk!
            let error : Error? = nil
            let data: Data? = nil
            return(response, data, error)
        }
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolStub.self]
        let session = URLSession(configuration: configuration)
        let weatherService = WeatherService(weatherSession: session)
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather { weatherDataError, weather in
            // Then
            XCTAssertEqual(weatherDataError, .invalidResponse)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.02)
    }
}
