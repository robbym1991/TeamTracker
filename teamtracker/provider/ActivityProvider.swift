//
//  ActivityProvider.swift
//  teamtracker
//
//  Created by Robby Michels on 01-06-18.
//  Copyright © 2018 Robby Michels. All rights reserved.
//

import Foundation
import UIKit

struct ActivityProvider {
    enum errorCodes: Int {
        case unAuthorized = 401
        case noJSON = -1
        case internalServerError = 500
        case notFound = 404
        case statusOk = 200
    }
    enum Results<T> {
        case Success(T)
        case Error(String)
    }
    
    static func getActivities(completion: @escaping (Results<NSArray>) -> Void) -> Void {
        var request: URLRequest
        do{
            request = try URLProvider.getURLRequestWithBearerToken(params: "", endpoint: Config.getUserActivity)
            let session = URLSession.shared
            session.dataTask(with: request) { (data, response, error) in
                if let response = response as? HTTPURLResponse {
                    if let data = data {
                        guard let json = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String: Any] else {
                            completion(.Error(StringConstants.noJSON))
                            return
                        }
                        
                        if let success = json["success"] as? [String: Any] {
                            if let activities = success["activities"] as? NSArray {
                                completion(.Success(activities))
                            }
                        }
                    
                        if(response.statusCode == errorCodes.notFound.rawValue) {
                            if let error = json["error"] as? String {
                                completion(.Error(error))
                            } else {
                                completion(.Error(StringConstants.pageNotFound))
                            }
                        } else {
                            // Return any other error given by api
                            completion(.Error(StringConstants.somethingWentWrong))
                        }
                    }
                    
                    if let _ = error {
                        completion(.Error(StringConstants.somethingWentWrong))
                    }
                }
            }.resume()
        } catch URLProvider.ErrorToThrow.NoValidURL {
            completion(.Error(StringConstants.somethingWentWrong))
        } catch URLProvider.ErrorToThrow.NoBearerToken {
            completion(.Error(StringConstants.somethingWentWrong))
        } catch {
            // Catch to misslead swift.
        }
    }
}
