//
//  URLSessionFakes.swift
//  travelAppTests
//
//  Created by Loranne Joncheray on 12/10/2022.
//

import Foundation
import XCTest


final class URLProtocolStub: URLProtocol {
    
    enum URLProtocolStubError : Error {
        case unknown
    }
    
    static var loadingHandler: ((URLRequest) ->(HTTPURLResponse, Data?, Error?))?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        guard let handler = URLProtocolStub.loadingHandler else {
            XCTFail("Loading handler is not set.")
            return
        }
        let (response, data, error) = handler(request)
            if let data = data {
                client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
                      client?.urlProtocol(self, didLoad: data)
                      client?.urlProtocolDidFinishLoading(self)
            } else {
                client?.urlProtocol(self, didFailWithError: error ?? URLProtocolStubError.unknown)
            }
    }
    override func stopLoading() {}
}
