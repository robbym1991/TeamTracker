//
//  teamtrackerTests.swift
//  teamtrackerTests
//
//  Created by Robby Michels on 07-02-18.
//  Copyright © 2018 Robby Michels. All rights reserved.
//

import XCTest
@testable import teamtracker

class teamtrackerTests: XCTestCase {
    var gameUnderTest: Activity!
    var sessionUnderTest: URLSession!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sessionUnderTest = URLSession(configuration: URLSessionConfiguration.default)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sessionUnderTest = nil
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testLoginApiCall() {
        // given
        let email = "robby@hva.nl"
        
        let password = "robbyy"
        // 1
        let promise = expectation(description: "Status code: 200")
        
        let param: String = "email=" + email + "&password=" + password
        do {
            let request: URLRequest = try URLProvider.postURLRequest(params: param, endpoint: Config.apiLogin)
            
            let dataTask = sessionUnderTest.dataTask(with: request) { data, response, error in
                // then
                if let error = error {
                    XCTFail("Error: \(error.localizedDescription)")
                    return
                } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    if statusCode == 200 {
                        // 2
                        promise.fulfill()
                    } else {
                        XCTFail("Status code: \(statusCode)")
                    }
                }
                
            }
            
            dataTask.resume()
            // 3
            waitForExpectations(timeout: 5, handler: nil)
            
        } catch URLProvider.ErrorToThrow.NoValidURL {
            print(StringConstants.somethingWentWrong)
        } catch {
            // Catch to misslead Swift
        }
    }
    
    func testLoginApiCallFalseCredentials() {
        // given email
        let email = "robby@hv.nl"
        // given password
        let password = "falsePassword"
        
        // Given Expectation
        let promise = expectation(description: "Status code: 200")
        
        // Params too send to API
        let param: String = "email=" + email + "&password=" + password
        do {
            //URL request object with parameters and the api url.
            let request: URLRequest = try URLProvider.postURLRequest(params: param, endpoint: Config.apiLogin)
            
            // Call object
            let dataTask = sessionUnderTest.dataTask(with: request) { data, response, error in
                // then
                if let error = error {
                    XCTFail("Error: \(error.localizedDescription)")
                    return
                } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    if statusCode != 200 {
                        // 2
                        promise.fulfill()
                    } else {
                        XCTFail("Status code: \(statusCode)")
                    }
                }
                
            }
            
            dataTask.resume()
            // 3
            waitForExpectations(timeout: 5, handler: nil)
            
        } catch URLProvider.ErrorToThrow.NoValidURL {
            print(StringConstants.somethingWentWrong)
        } catch {
            // Catch to misslead Swift
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
