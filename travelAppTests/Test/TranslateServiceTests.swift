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
    func testTranslateShouldPostFailedCallBackIfError() {
        // Given
        let translateService = TranslateService(translateSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.errorTranslate))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        translateService.getTranslation(text: "Ma maison est bleue") { translateDataError, translate in
            // Then
            XCTAssertEqual(translateDataError, .invalideResponse)
            XCTAssertNil(translate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // pas de data recu avec l'appel
    func testTranslateShouldPostFailedCallBackIfNoData() {
        // Given
        let translateService = TranslateService(translateSession: URLSessionFake(data: nil, response: nil, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        translateService.getTranslation(text: "Ma maison est bleu") { translateDataError, translate in
            // Then
            XCTAssertEqual(translateDataError, .invalideResponse)
            XCTAssertNil(translate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // donnée correct mais reponse pas correct
    func testGetTranslateShouldPostFailedCallBackIfIncorrectResponse() {
        // Given
        let translateService = TranslateService(translateSession: URLSessionFake(data: FakeResponseData.translateCorrectData , response: FakeResponseData.reponseKO, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        translateService.getTranslation(text: "Ma maison est bleu") { translateDataError, translate in
            // Then
            XCTAssertEqual(translateDataError, .invalideResponse)
            XCTAssertNil(translate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // donnée incorrect mais réponse correct
    func testGetTranslateShouldPostFailedCallBackIfIncorrectData() {
        // Given
        let translateService = TranslateService(translateSession: URLSessionFake(data: FakeResponseData.translateIncorrectData , response: FakeResponseData.responseOk, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        translateService.getTranslation(text: "Ma maison est bleu") { translateDataError, translate in
            // Then
            XCTAssertEqual(translateDataError, .invalideResponse)
            XCTAssertNil(translate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // Tout ok
    func testGetTranslateShouldPostSuccessCallBackIfNoErrorAndCorrectData() {
        // Given
        let translateService = TranslateService(translateSession: URLSessionFake(data: FakeResponseData.translateCorrectData , response: FakeResponseData.responseOk, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        translateService.getTranslation(text: "Ma maison est bleu") { translateDataError, translate in
            // Then
            XCTAssertNil(translateDataError)
            XCTAssertNotNil(translate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func  testGetTranslateShouldSendBackSuccessFullAndCorrectDataIfCorrectAnswer() {
        // Given
        let translateService = TranslateService(translateSession: URLSessionFake(data: FakeResponseData.translateCorrectData , response: FakeResponseData.responseOk, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        translateService.getTranslation(text: "Ma maison est bleu") { (translateDataError, translate) in
            // Then
            XCTAssertNil(translateDataError)
            XCTAssertNotNil(translate)
            XCTAssertEqual(translate?.translations[0].text, "My house is blue" )
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func  testGetTranslateShouldSendBackSuccessFullAndCorrectDataIfCorrectAnswerAndDetectedLanguageFR() {
        // Given
        let translateService = TranslateService(translateSession: URLSessionFake(data: FakeResponseData.translateCorrectData , response: FakeResponseData.responseOk, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        translateService.getTranslation(text: "Ma maison est bleu") { (translateDataError, translate) in
            // Then
            XCTAssertNil(translateDataError)
            XCTAssertNotNil(translate)
            XCTAssertEqual(translate?.translations[0].detected_source_language, "FR")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
