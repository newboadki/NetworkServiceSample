//
//  ServiceLayer+IntroductionAPI.swift
//  IntroduceYourself
//
//  Created by Borja Arias Drake on 01/07/2017.
//  Copyright © 2017 Borja Arias Drake. All rights reserved.
//

import Foundation


// MARK: - Introduction API

/// High-level API to introduce yourself
extension NetworkService {
    
    /// Performs a POST, including the passed parameters in the JSON body
    ///
    /// - Parameters:
    ///   - name: Person that wants to introduce himself.
    ///   - email: email.
    ///   - about: short description about the person.
    ///   - urls: Links of interest.
    ///   - teams: Areas of interest.
    ///   - completion: completion block that will be called in the main thread.
    public func introduceYourself(name: String,
                                  email: String,
                                  about: String,
                                  urls: [String],
                                  teams: [String],
                                  completion: @escaping ((_ response: URLResponse?, _ error: Error?) -> ())) {
        
        let jobApplicationRequest = self.jobApplicationRequest(name:name, email:email, about:about, urls:urls, teams:teams)
        self.perform(request: jobApplicationRequest, completion: completion)
    }
    
    
    /// Constructs a request for a given endpoint.
    ///
    /// - Parameters:
    ///   - name: name
    ///   - email: email
    ///   - about: description
    ///   - urls: links of interest
    ///   - teams: Areas of interest
    /// - Returns: a request to introduce yourself.
    private func jobApplicationRequest(name: String,
                                       email: String,
                                       about: String,
                                       urls: [String],
                                       teams: [String]) -> URLRequest {
        let url = URL(string: "http://localhost:3000/introduction")
        let request = NSMutableURLRequest(url: url!)
        
        // Headers
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        // Fields
        request.httpMethod = "POST"
        
        // Body
        let bodyDictionary: Dictionary<String, Any> = ["name" : name,
                                                       "email" : email,
                                                       "about" : about,
                                                       "urls" : urls,
                                                       "teams" : teams]
        
        if let body = self.jobApplicationBodyData(from: bodyDictionary) {
            request.httpBody = body
        }
        
        return request as URLRequest
    }
    
    
    /// Serializes a dictionary into data that encodes JSON
    ///
    /// - Parameter bodyDictionary: body
    /// - Returns: a Data instance containing the passed dictionary in JSON format. Nil if the operation could not be completed.
    private func jobApplicationBodyData(from bodyDictionary: Dictionary<String, Any>) -> Data? {
        do {
            let bodyData = try JSONSerialization.data(withJSONObject: bodyDictionary, options: .prettyPrinted)
            return bodyData
        } catch _ {
            return nil
        }
    }
}
