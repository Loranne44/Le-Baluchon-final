//
//  ExchangeServiceTests.swift
//  travelAppTests
//
//  Created by Loranne Joncheray on 12/10/2022.
//




@testable import travelApp

import XCTest

final class ExchangeServiceTest: XCTestCase {
    
    func testExchangeShouldPostFailedCallBackIfError() {
        // Given
        URLProtocolStub.loadingHandler = { request in
            let response : HTTPURLResponse = FakeResponseData.responseOk!
            let error : Error? = FakeResponseData.errorExchange
            let data: Data? = nil
            return(response, data, error)
        }
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolStub.self]
        let session = URLSession(configuration: configuration)
        let exchangeService = ExchangeService(exchangeSession: session)
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        exchangeService.getExchangeCurrency { exchangeDataError, rate in
            
            // Then
            XCTAssertEqual(exchangeDataError, .invalidResponse)
            XCTAssertNil(rate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetExchangeCurrencyShouldPostFailedCallBackIfNoData() {
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
        let exchangeService = ExchangeService(exchangeSession: session)
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        exchangeService.getExchangeCurrency { exchangeDataError, rate in
            
            // Then
            XCTAssertEqual(exchangeDataError, .invalidResponse)
            XCTAssertNil(rate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetExchangeCurrencyShouldPostFailedCallBackIfIncorrectResponse() {
        // Given
        URLProtocolStub.loadingHandler = { request in
            let response : HTTPURLResponse = FakeResponseData.responseOk!
            let error : Error? = nil
            let data: Data? = FakeResponseData.exchangeIncorrectData
            return(response, data, error)
        }
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolStub.self]
        let session = URLSession(configuration: configuration)
        let exchangeService = ExchangeService(exchangeSession: session)
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        exchangeService.getExchangeCurrency { exchangeDataError, rate in
            
            // Then
            XCTAssertEqual(exchangeDataError, .invalidResponse)
            XCTAssertNil(rate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
        
    func testGetExchangeCurrencyShouldPostFailedCallBackIfIncorrectData() {
        // Given
        URLProtocolStub.loadingHandler = { request in
            let response : HTTPURLResponse = FakeResponseData.responseOk!
            let error : Error? = nil
            let data: Data? = FakeResponseData.exchangeIncorrectData
            return(response, data, error)
        }
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolStub.self]
        let session = URLSession(configuration: configuration)
        let exchangeService = ExchangeService(exchangeSession: session)
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        exchangeService.getExchangeCurrency { exchangeDataError, rate in
            
            // Then
            XCTAssertEqual(exchangeDataError, .invalidResponse)
            XCTAssertNil(rate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
        
    func getDateFromString(stringDate: String) -> Date {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: stringDate)!
    }
    
    func testGetExchangeCurrencyShouldGetSuccessCallbackIfNoErrorAndCorrectDataUSDAndDate() {
        // Given
        URLProtocolStub.loadingHandler = { request in
            let response : HTTPURLResponse = FakeResponseData.responseOk!
            let error : Error? = nil
            let data: Data? = FakeResponseData.exchangeCorrectData
            return(response, data, error)
        }
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolStub.self]
        let session = URLSession(configuration: configuration)
        let exchangeService = ExchangeService(exchangeSession: session)
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        let date =  getDateFromString(stringDate: "2022-10-18")
        exchangeService.getExchangeCurrency(date: date) { exchangeDataError, rate in
            // Then
            XCTAssertNil(exchangeDataError)
            XCTAssertEqual(rate?.rates["USD"], 0.970878)
            XCTAssertEqual(rate?.date, "2022-10-18")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
        
    /*
    
   // ------------------------------ ?? ---------
    func testGetExchangeCurrencyShouldGetSuccessCallbackIfErrorAndIncorrectDate() {
        // Given
        URLProtocolStub.loadingHandler = { request in
            let response : HTTPURLResponse = FakeResponseData.responseOk!
            let error : Error? = nil
            let data: Data? = FakeResponseData.exchangeIncorrectData
            return(response, data, error)
        }
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolStub.self]
        let session = URLSession(configuration: configuration)
        let exchangeService = ExchangeService(exchangeSession: session)
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        let date =  getDateFromString(stringDate: "2022-10-18")
        exchangeService.getExchangeCurrency(date: date) { exchangeDataError, rate in
            // Then
            XCTAssertEqual(exchangeDataError, .invalidResponse)
            XCTAssertEqual(rate?.date, "2022-10-11")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }*/
}

// Test erreur création url -> API KEY

// test de la méthode convertCurrencies
