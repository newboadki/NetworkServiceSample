//
//  URLSessionMock.swift
//  IntroduceYourselfTests
//
//  Created by Borja Arias Drake on 01/07/2017.
//  Copyright © 2017 Borja Arias Drake. All rights reserved.
//

import Foundation

class URLSessionMock : NetworkSession {
    
    var error : Error?
    var data : Data?
    var response : URLResponse?
    
    init(error: Error?) {
        self.error = error
    }
    
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) -> URLSessionDataTask {
        let task = URLSessionDataTaskMock(error: self.error,
                                          response: self.response,
                                          data: self.data,
                                          completion: completionHandler)
        return task
    }
}
