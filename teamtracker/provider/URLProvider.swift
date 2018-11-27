//
//  URLProvider.swift
//  teamtracker
//
//  Created by Robby Michels on 23-03-18.
//  Copyright © 2018 Robby Michels. All rights reserved.
//

import Foundation
import UIKit

struct URLProvider {
    enum ErrorToThrow: Error {
        case NoValidURL
        case NoBearerToken
    }
    
    static func postURLRequest(params: String, endpoint: String) throws -> URLRequest {
        let param: String = params
        
        guard let url = URL(string: Config.apiURL + endpoint) else { throw ErrorToThrow.NoValidURL }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = param.data(using: .utf8)
        
        return request
    }
    
    static func postURLRequestWithBearerToken(params: String, endpoint: String) throws -> URLRequest {
        let param: String = params
        let defaults = UserDefaults.standard
        guard let bearertoken = defaults.string(forKey: StringConstants.defaultsKeys.bearerToken.rawValue) else {
            throw ErrorToThrow.NoBearerToken
        }
            
        guard let url = URL(string: Config.apiURL + endpoint) else { throw ErrorToThrow.NoValidURL }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("Bearer " + bearertoken, forHTTPHeaderField: "Authorization")
        request.httpBody = param.data(using: .utf8)
        
        return request
    }
    
    static func getURLRequestWithBearerToken(params: String, endpoint: String) throws -> URLRequest {
        let param: String = params
        let defaults = UserDefaults.standard
        guard let bearertoken = defaults.string(forKey: StringConstants.defaultsKeys.bearerToken.rawValue) else {
            throw ErrorToThrow.NoBearerToken
        }
        
        guard let url = URL(string: Config.apiURL + endpoint) else { throw ErrorToThrow.NoValidURL }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("Bearer " + bearertoken, forHTTPHeaderField: "Authorization")
        request.httpBody = param.data(using: .utf8)
        
        return request
    }
}
