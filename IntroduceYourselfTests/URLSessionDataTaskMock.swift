//
//  URLSessionDataTaskMock.swift
//  IntroduceYourselfTests
//
//  Created by Borja Arias Drake on 01/07/2017.
//  Copyright © 2017 Borja Arias Drake. All rights reserved.
//

import Foundation

class URLSessionDataTaskMock : URLSessionDataTask {
    
    var _error : Error?
    var _response : URLResponse?
    var data : Data?    
    var completion: (Data?, URLResponse?, Error?) -> Swift.Void
    
    override var error: Error? {
        get {
            return _error
        }
    }
    
    override var response: URLResponse? {
        get {
            return _response
        }
    }
    
    init(error: Error?, response: URLResponse?, data: Data?, completion: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) {
        _error = error
        _response = response
        self.data = data
        self.completion = completion
    }
    
    override func resume() {
        self.completion(self.data, self.response, self.error)
    }
    
    override func cancel() {}
    
    
}
