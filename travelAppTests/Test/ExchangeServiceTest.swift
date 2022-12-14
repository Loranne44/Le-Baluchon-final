//
//  ExchangeServiceTest.swift
//  travelAppTests
//
//  Created by Loranne Joncheray on 11/10/2022.
//
@testable import travelApp
import XCTest

final class ExchangeServiceTest: XCTestCase {
    // si jai une erreur
    func testGetExchangeCurrencyShouldPostFailedCallBackIfError() {
        // Given
        let exchangeService = ExchangeService(exchangeSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.errorExchange))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        exchangeService.getExchangeCurrency { exchangeDataError, rate in
            // Then
            XCTAssertEqual(exchangeDataError, .invalideResponse)
            XCTAssertNil(rate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // pas de data recu avec l'appel
    func testGetExchangeCurrencyShouldPostFailedCallBackIfNoData() {
        // Given
        let exchangeService = ExchangeService(exchangeSession: URLSessionFake(data: nil, response: nil, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        exchangeService.getExchangeCurrency { exchangeDataError, rate in
            // Then
            XCTAssertEqual(exchangeDataError, .invalideResponse)
            XCTAssertNil(rate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // donnée correct mais reponse pas correct
    func testGetExchangeCurrencyShouldPostFailedCallBackIfIncorrectResponse() {
        // Given
        let exchangeService = ExchangeService(exchangeSession: URLSessionFake(data: FakeResponseData.exchangeCorrectData , response: FakeResponseData.reponseKO, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        exchangeService.getExchangeCurrency { exchangeDataError, rate in
            // Then
            XCTAssertEqual(exchangeDataError, .invalideResponse)
            XCTAssertNil(rate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // donnée incorrect mais réponse correct
    func testGetExchangeCurrencyShouldPostFailedCallBackIfIncorrectData() {
        // Given
        let exchangeService = ExchangeService(exchangeSession: URLSessionFake(data: FakeResponseData.exchangeIncorrectData , response: FakeResponseData.responseOk, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        exchangeService.getExchangeCurrency { exchangeDataError, rate in
            // Then
            XCTAssertEqual(exchangeDataError, .invalideResponse)
            XCTAssertNil(rate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // Tout ok
    func testGetExchangeCurrencyShouldPostSuccessCallBackIfNoErrorAndCorrectData() {
        // Given
        let exchangeService = ExchangeService(exchangeSession: URLSessionFake(data: FakeResponseData.exchangeCorrectData , response: FakeResponseData.responseOk, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        exchangeService.getExchangeCurrency { exchangeDataError, rate in
            // Then
            XCTAssertEqual(exchangeDataError, .none)
            XCTAssertNotNil(rate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // Test erreur création url -> API KEY
    
    // test de la méthode convertCurrencies
}
