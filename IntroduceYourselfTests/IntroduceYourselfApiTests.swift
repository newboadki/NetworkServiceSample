//
//  IntroduceYourselfTests.swift
//  IntroduceYourselfTests
//
//  Created by Borja Arias Drake on 01/07/2017.
//  Copyright © 2017 Borja Arias Drake. All rights reserved.
//

import XCTest

class IntroduceYourselfTests: XCTestCase {
    
    func testTheresResponseAndNotErrorWhenCompletionBlockCalledOnSuccessScenario() {
        let session = URLSessionMock(error: nil)
        let responseMock = URLResponse(url: URL(string: "https://localhost:3000")!, mimeType: nil, expectedContentLength: 0, textEncodingName: "UTF8")
        session.response = responseMock
        let service = NetworkService(session: session)
        
        let exp = expectation(description: "exp")
        service.introduceYourself(name: "test-user",
                                  email: "a@b.c",
                                  about: "desc",
                                  urls: ["a.com", "b.com"],
                                  teams: ["A-team"]) { (response, error) in
                                    
                                    XCTAssertNil(error)
                                    XCTAssert(response === responseMock)
                                    exp.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testTheresErrorWhenCompletionBlockCalledOnfailureScenario() {
        let session = URLSessionMock(error: NSError(domain: "error", code: 1, userInfo: nil))
        let responseMock = URLResponse(url: URL(string: "https://localhost:3000")!, mimeType: nil, expectedContentLength: 0, textEncodingName: "UTF8")
        session.response = responseMock
        let service = NetworkService(session: session)
        
        let exp = expectation(description: "exp")
        
        service.introduceYourself(name: "test-user",
                                  email: "a@b.c",
                                  about: "desc",
                                  urls: ["a.com", "b.com"],
                                  teams: ["A-team"]) { (response, error) in
                                    
                                    XCTAssertNotNil(error)
                                    XCTAssert(response === responseMock)
                                    exp.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
}
