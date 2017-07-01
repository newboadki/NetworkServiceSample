//
//  NetworkSession.swift
//  IntroduceYourself
//
//  Created by Borja Arias Drake on 01/07/2017.
//  Copyright © 2017 Borja Arias Drake. All rights reserved.
//

import Foundation

protocol NetworkSession {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) -> URLSessionDataTask
}

protocol NetworkTask {
    func resume()
    func cancel()
}

extension URLSessionDataTask : NetworkTask {}
extension URLSession : NetworkSession {}

