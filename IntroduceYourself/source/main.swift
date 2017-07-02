//
//  main.swift
//  IntroduceYourself
//
//  Created by Borja Arias Drake on 01/07/2017.
//  Copyright © 2017 Borja Arias Drake. All rights reserved.
//

import Foundation

/*
 This program implements a network service that calls an API via POST. Equivalent to the following:
     curl -H "Content-Type: application/json" -X POST -d '{"name":"Borja", "email": "a@b.com","about":"description","urls":["u1","u2"], "teams":["a"]}' http://localhost:3000/introduction
 */




var urlSession = URLSession(configuration: URLSessionConfiguration.default)
var service = NetworkService(session: urlSession)

let aboutSection = ""

let urlArray = ["https://www.linkedin.com/in/borjaarias/",
                 "https://github.com/newboadki",
                 "https://itunes.apple.com/us/app/expenses-budget-tracker/id698887411?mt=8",
                 "http://borjaarias.herokuapp.com"]

service.introduceYourself(name: "Borja Arias Drake",
                          email: "borja.arias@gmal.com",
                          about: aboutSection,
                          urls: urlArray,
                          teams: ["ios"]) { (response, error) in    
    if error != nil {
        print(error!)
    } else {
        // Success
        print(response!)
    }
}

// Keep the program running to guarantee there's enough time for the network call to run.
while (true) {}



