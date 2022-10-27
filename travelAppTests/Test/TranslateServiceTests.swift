//
//  TranslateServiceTests.swift
//  travelAppTests
//
//  Created by Loranne Joncheray on 12/10/2022.
//

@testable import travelApp
import XCTest

final class TranslateServiceTest: XCTestCase {
    
    func testTranslateShouldPostFailedCallBackIfError() {
        // Given
        URLProtocolStub.loadingHandler = { request in
            let response : HTTPURLResponse = FakeResponseData.responseOk!
            let error : Error? = FakeResponseData.errorTranslate
            let data: Data? = nil
            return(response, data, error)
        }
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolStub.self]
        let session = URLSession(configuration: configuration)
        let translateService = TranslateService(translateSession: session)
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translateService.getTranslation(text: "Ma maison est bleue") { translateDataError, translate in
            // Then
            XCTAssertEqual(translateDataError, .invalidResponse)
            XCTAssertNil(translate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testTranslateShouldPostFailedCallBackIfNoData() {
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
        let translateService = TranslateService(translateSession: session)
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translateService.getTranslation(text: "Ma maison est bleue") { translateDataError, translate in
            // Then
            XCTAssertEqual(translateDataError, .invalidResponse)
            XCTAssertNil(translate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslateShouldPostFailedCallBackIfIncorrectResponse() {
        // Given
        URLProtocolStub.loadingHandler = { request in
            let response : HTTPURLResponse = FakeResponseData.reponseKO!
            let error : Error? = nil
            let data: Data? = FakeResponseData.translateCorrectData
            return(response, data, error)
        }
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolStub.self]
        let session = URLSession(configuration: configuration)
        let translateService = TranslateService(translateSession: session)
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translateService.getTranslation(text: "Ma maison est bleue") { translateDataError, translate in
            // Then
            XCTAssertEqual(translateDataError, .invalidResponse)
            XCTAssertNil(translate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslateShouldPostFailedCallBackIfIncorrectData() {
        // Given
        URLProtocolStub.loadingHandler = { request in
            let response : HTTPURLResponse = FakeResponseData.responseOk!
            let error : Error? = nil
            let data: Data? = FakeResponseData.translateIncorrectData
            return(response, data, error)
        }
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolStub.self]
        let session = URLSession(configuration: configuration)
        let translateService = TranslateService(translateSession: session)
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translateService.getTranslation(text: "Ma maison est bleue") { translateDataError, translate in
            // Then
            XCTAssertEqual(translateDataError, .invalidResponse)
            XCTAssertNil(translate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslateShouldPostSuccessCallBackIfNoErrorAndCorrectData() {
        // Given
        URLProtocolStub.loadingHandler = { request in
            let response : HTTPURLResponse = FakeResponseData.responseOk!
            let error : Error? = nil
            let data: Data? = FakeResponseData.translateCorrectData
            return(response, data, error)
        }
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolStub.self]
        let session = URLSession(configuration: configuration)
        let translateService = TranslateService(translateSession: session)
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translateService.getTranslation(text: "Ma maison est bleue") { translateDataError, translate in
            // Then
            XCTAssertNil(translateDataError)
            XCTAssertNotNil(translate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslateShouldSendBackSuccessFullAndCorrectDataIfCorrectAnswer() {
        // Given
        URLProtocolStub.loadingHandler = { request in
            let response : HTTPURLResponse = FakeResponseData.responseOk!
            let error : Error? = nil
            let data: Data? = FakeResponseData.translateCorrectData
            return(response, data, error)
        }
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolStub.self]
        let session = URLSession(configuration: configuration)
        let translateService = TranslateService(translateSession: session)
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translateService.getTranslation(text: "Ma maison est bleue") { translateDataError, translate in
            // Then
            XCTAssertNil(translateDataError)
            XCTAssertEqual(translate?.translations[0].text, "My house is blue" )
            XCTAssertEqual(translate?.translations[0].detected_source_language, "FR")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
