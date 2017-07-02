//
//  NetworkSession.swift
//  IntroduceYourself
//
//  Created by Borja Arias Drake on 01/07/2017.
//  Copyright © 2017 Borja Arias Drake. All rights reserved.
//

import Foundation

/*
 * In order to make testing easier, the session implementation is decoupled from the Network service implemetation.
 */
protocol NetworkSession {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) -> URLSessionDataTask
}

protocol NetworkTask {
    func resume()
    func cancel()
}

/*
 * We extend the system classes to formalice the conformance to the protocols above.
 * Since these two classes already conform to them.
 */
extension URLSessionDataTask : NetworkTask {}
extension URLSession : NetworkSession {}

