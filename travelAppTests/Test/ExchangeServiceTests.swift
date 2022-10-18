//
//  ExchangeServiceTests.swift
//  travelAppTests
//
//  Created by Loranne Joncheray on 12/10/2022.
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

    
    // ________________________ A REVOIR _________________________________________
    
    func testGetExchangeCurrencyShouldGetSuccessCallbackIfNoErrorAndCorrectDataUSDAndDate() {
        let exchangeService = ExchangeService(exchangeSession: URLSessionFake(data: FakeResponseData.exchangeCorrectData, response: FakeResponseData.responseOk, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        exchangeService.getExchangeCurrency { exchangeDataError, rate in
            // Then
            XCTAssertNil(exchangeDataError)
            // _____________ base "EUR" COMMENT Y ACCEDER ___________________
            // XCTAssertEqual(, "EUR")
            XCTAssertEqual(rate?.rates, ["USD": 0.970878])
            XCTAssertEqual(rate?.date, "2022-10-18")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetExchangeCurrencyShouldPostFailedCallBackIfErrorDate() {
        let exchangeService = ExchangeService(exchangeSession: URLSessionFake(data: FakeResponseData.exchangeIncorrectData, response: FakeResponseData.responseOk, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        exchangeService.getExchangeCurrency { exchangeDataError, rate in
            // Then
            XCTAssertNotEqual(rate?.date, "2022-10-11")
            XCTAssertEqual(exchangeDataError, .invalidDate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
   

    
    /*func testConvertCurrencyShouldSendBackCorrectAnswerIfRatesAreRefreshed() {
        let exchangeService = ExchangeService(
            exchangeSession: URLSessionFake(
                data: FakeResponseData.exchangeCorrectData, response: FakeResponseData.responseOk, error: nil))
        let expectaction = XCTestExpectation(description: "Wait for queue change.")
        exchangeService.getExchangeCurrency { (exchangeDataError, rate) in
            XCTAssertEqual(exchangeDataError, .none)
            XCTAssertEqual(ExchangeService.shared.convertCurrencies(dataCurrencieTarget: rate!, currencieKey: "USD", euroValue: 1.000), "0.970878")
            expectaction.fulfill()
        }
        wait(for: [expectaction], timeout: 0.01)
    }*/
}

// Test erreur création url -> API KEY

// test de la méthode convertCurrencies


// Moke
// Qd appel web service il renvoi un json
// Faire en boucle fermé
// QD on va demander à son application
