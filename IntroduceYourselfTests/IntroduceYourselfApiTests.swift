//
//  IntroduceYourselfTests.swift
//  IntroduceYourselfTests
//
//  Created by Borja Arias Drake on 01/07/2017.
//  Copyright © 2017 Borja Arias Drake. All rights reserved.
//

import XCTest

/*
 * What I am looking to test in any component is its contract, or public API, while mocking
 * dependencies that are either not reliable enough for testing, like the network, or too slow/expensive.
 *
 * - In this NetworkService sample, the public API are the completion block and the parameters called in it,
 *   which should match the mocked network conditions.
 * - Another behaviour exposed through the use of the public API (and therefore should be tested) is the
 *   cancellation of the previous task, which I assumed to make it simpler.
 */

class IntroduceYourselfTests: XCTestCase {
    
    func testTheresResponseAndNotErrorWhenCompletionBlockCalledOnSuccessScenario() {
        // Setup the objects.
        let session = URLSessionMock(error: nil) // NO ERROR -> SUCCESS
        let responseMock = URLResponse(url: URL(string: "https://localhost:3000")!, mimeType: nil, expectedContentLength: 0, textEncodingName: "UTF8")
        session.response = responseMock
        let service = NetworkService(session: session)
        
        // Run the test
        let exp = expectation(description: "exp")
        service.introduceYourself(name: "test-user", email: "a@b.c", about: "desc", urls: ["a.com", "b.com"], teams: ["A-team"]) {
            (response, error) in
                XCTAssertNil(error)
                XCTAssert(response === responseMock)
                exp.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testTheresErrorWhenCompletionBlockCalledOnfailureScenario() {
        // Setup the objects.
        let session = URLSessionMock(error: NSError(domain: "error", code: 1, userInfo: nil)) // Error -> Failure
        let responseMock = URLResponse(url: URL(string: "https://localhost:3000")!, mimeType: nil, expectedContentLength: 0, textEncodingName: "UTF8")
        session.response = responseMock
        let service = NetworkService(session: session)
        
        let exp = expectation(description: "exp")
        
        // Run the test
        service.introduceYourself(name: "test-user", email: "a@b.c", about: "desc", urls: ["a.com", "b.com"], teams: ["A-team"]) {
            (response, error) in
                XCTAssertNotNil(error)
                XCTAssert(response === responseMock)
                exp.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    /*
     Cancelation of tasks can and should be tested in a commercial scenario,
     introducing logic into the session and task mocks to delay the call of the completion blocks.
     With this in place, the test would:
         - perform two calls to the API method under test
         - Expect that the first completion block does not get called.
         - Expect that the second completion call gets called.
     */
}
