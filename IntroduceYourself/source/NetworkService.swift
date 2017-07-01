//
//  NetworkApplicationController.swift
//  IntroduceYourself
//
//  Created by Borja Arias Drake on 01/07/2017.
//  Copyright © 2017 Borja Arias Drake. All rights reserved.
//

import Foundation



/// - This class contains the high-level knowledge necessary for making network calls to a given backend service.
///   That includes the basic configuration, authentication credentials, headers and any info necessary about
///   the responses, that are shared between endpoints of the same service.
///
/// - It decouples the rest of the application from the specifics of the network layer.
/// - This class does not support multiple requests in parallel. It cancels the previous request and starts a new one.
///   This is for simplicity as allowing multiple requests in-flight and cancelling them requires to expose a request
///   identifier out to the application. Note that it would be preferrable to expose an identifier an not the task as that's
///   a network technology implementation detail.
class NetworkService {
    
    /// Lower-level technology to perform network request
    private(set) var session: NetworkSession
    
    /// Reference to the last in-flight task
    private var lastDataTask: NetworkTask?
    
    /// Reference to the last in-flight task's completion block
    private var lastCompletionBlock: ((_ response: URLResponse?, _ error: Error?) -> () )?
    
    
    
    /// Designated Initializer
    ///
    /// - Parameter session: session to be used.
    public required init(session: NetworkSession) {
        self.session = session
    }
    
    
    /// Encapsulates the logic to make network calls, configure the requests,and work necessary to cancel them, etc.
    ///
    /// - Parameters:
    ///   - request: request to be submitted
    ///   - completion: completion block.
    public func perform(request: URLRequest, completion: @escaping ((_ response: URLResponse?, _ error: Error?) -> ())) {
        
        // Cancel the previous call
        if let previousTask = self.lastDataTask {
            previousTask.cancel()
        }
        
        // Get hold of the completion block
        self.lastCompletionBlock = completion
        
        // Prepare the network call
        self.lastDataTask = self.session.dataTask(with: request, completionHandler: { (data, response, error) in
            self.callCompletionInMainThread(response: response, error: error)
        })
        
        // Execute the network call
        self.lastDataTask?.resume()
    }
    
    
    /// Helper method to return control to the client class in the main thread.
    ///
    /// - Parameters:
    ///   - response: network response
    ///   - error: error.
    private func callCompletionInMainThread(response: URLResponse?, error: Error?) {
        DispatchQueue.main.async {
            self.lastCompletionBlock!(response, error)
            self.lastCompletionBlock = nil
        }
    }
}


