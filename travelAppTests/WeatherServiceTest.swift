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
    
    // _________ FINIR ____
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



/*

final class WeatherServiceTest: XCTestCase {
    
    // si jai une erreur
    func testGetExchangeCurrencyShouldPostFailedCallBackIfError() {
        // Given
        let weatherService = WeatherService(weatherSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.errorWeather))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        weatherService.getWeather { weatherDataError, weather in
            // Then
            XCTAssertEqual(weatherDataError, .invalidResponse)
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
            XCTAssertEqual(weatherDataError, .invalidResponse)
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
            XCTAssertEqual(weatherDataError, .invalidResponse)
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
            XCTAssertEqual(weatherDataError, .invalidResponse)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.02)
    }
    
    // Tout ok
    func testGetExchangeCurrencyShouldPostSuccessCallBackIfNoErrorAndCorrectData() {
        // Given
        let weatherService = WeatherService(weatherSession: URLSessionFake(data: FakeResponseData.weatherCorrectData , response: FakeResponseData.responseOk, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        weatherService.getWeather { weatherDataError, weather in
            // Then
            XCTAssertNil(weatherDataError)
            XCTAssertNotNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeatherShouldSendBackSuccessFullAndCorrectDataIfCorrectAnswerNantes() {
        let weatherService = WeatherService(
            weatherSession: URLSessionFake(
                data: FakeResponseData.weatherCorrectData, response: FakeResponseData.responseOk, error: nil))
        let expectaction = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather { (weatherDataError, weather) in
            XCTAssertNil(weatherDataError)
            XCTAssertEqual(weather?.list[0].weather[0].description, "overcast clouds")
            XCTAssertEqual(weather?.list[0].main.temp, 13.8)
            expectaction.fulfill()
        }
        wait(for: [expectaction], timeout: 0.01)
    }
    
    func testGetWeatherShouldSendBackSuccessFullAndCorrectDataIfCorrectAnswerNYC() {
        let weatherService = WeatherService(
            weatherSession: URLSessionFake(
                data: FakeResponseData.weatherCorrectData, response: FakeResponseData.responseOk, error: nil))
        
        // When
        let expectaction = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather { (weatherDataError, weather) in
            
            // Then
            XCTAssertNil(weatherDataError)
            XCTAssertEqual(weather?.list[1].weather[0].description, "clear sky")
            XCTAssertEqual(weather?.list[1].main.temp, 11.77)
            expectaction.fulfill()
        }
        wait(for: [expectaction], timeout: 0.01)
    }
}

*/
