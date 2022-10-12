//
//  TranslateServiceTests.swift
//  travelAppTests
//
//  Created by Loranne Joncheray on 12/10/2022.
//

@testable import travelApp
import XCTest

final class TranslateServiceTest: XCTestCase {

    // si jai une erreur
    func testGetExchangeCurrencyShouldPostFailedCallBackIfError() {
        // Given
        let translateService = TranslateService(translateSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.errorTranslate))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        translateService.getTranslation(text: "My house is blue") { translateDataError, translate in
            // Then
            XCTAssertEqual(translateDataError, .invalideResponse)
            XCTAssertNil(translate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // pas de data recu avec l'appel
    func testGetExchangeCurrencyShouldPostFailedCallBackIfNoData() {
        // Given
        let translateService = TranslateService(translateSession: URLSessionFake(data: nil, response: nil, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        translateService.getTranslation(text: "My house is blue") { translateDataError, translate in
            // Then
            XCTAssertEqual(translateDataError, .invalideResponse)
            XCTAssertNil(translate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // donnée correct mais reponse pas correct
    func testGetExchangeCurrencyShouldPostFailedCallBackIfIncorrectResponse() {
        // Given
        let translateService = TranslateService(translateSession: URLSessionFake(data: FakeResponseData.translateCorrectData , response: FakeResponseData.reponseKO, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        translateService.getTranslation(text: "My house is blue") { translateDataError, translate in
            // Then
            XCTAssertEqual(translateDataError, .invalideResponse)
            XCTAssertNil(translate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // donnée incorrect mais réponse correct
    func testGetExchangeCurrencyShouldPostFailedCallBackIfIncorrectData() {
        // Given
        let translateService = TranslateService(translateSession: URLSessionFake(data: FakeResponseData.translateIncorrectData , response: FakeResponseData.responseOk, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        translateService.getTranslation(text: "My house is blue") { translateDataError, translate in
            // Then
            XCTAssertEqual(translateDataError, .invalideResponse)
            XCTAssertNil(translate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // Tout ok
    func testGetExchangeCurrencyShouldPostSuccessCallBackIfNoErrorAndCorrectData() {
        // Given
        let translateService = TranslateService(translateSession: URLSessionFake(data: FakeResponseData.translateCorrectData , response: FakeResponseData.responseOk, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        translateService.getTranslation(text: "My house is blue") { translateDataError, translate in
            // Then
            XCTAssertEqual(translateDataError, .none)
            XCTAssertNotNil(translate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

}
