//
//  Login.swift
//  teamtracker
//
//  Created by Robby Michels on 14-02-18.
//  Copyright © 2018 Robby Michels. All rights reserved.
//

import Foundation
import UIKit

//renaming all file later..
struct LoginCalls {
    
    let headers = [
        "Authorization": "Bearer" + Config.clientToken,
        "Accept": "application/json"
    ]
    
    static func login(completion: @escaping ([String]) -> Void) {
        let apiValues = Bundle.main.infoDictionary?["Api values"] as? [String: String]
        let apiAddress = apiValues!["Api-address"]
        
        Alamofire.request(
            URL(string: apiAddress!)!,
            headers: [ "Authorization": "Bearer QWxhZGRpbjpvcGVuIHNlc2FtZQ==",
                       "Accept": "application/json"
                    ]
        )
        .responseJSON { response in
            guard response.result.isSuccess else {
                print("Error while fetching tags: \(response.result.error)")
                completion([String]())
                return
            }
                
            guard let responseJSON = response.result.value as? [String: Any] else {
                print("Invalid tag information received from the service")
                completion([String]())
                return
            }
                
            print(responseJSON)
            completion([String]())
        }
    }
    
//    static func login(completion: @escaping (Bool?) -> Void) {
//        let apiValues = Bundle.main.infoDictionary?["Api values"] as? [String: String]
//        let ApiAddress = apiValues!["Api-address"]
//        
//        Alamofire.request(
//            //change this url
//            URL(string: ApiAddress!)!,
//            method: .get,
//            //use parameters to include body?
//            parameters: ["include_docs": "true"])
//            .validate()
//            .responseJSON { (response) -> Void in
//                guard response.result.isSuccess else {
//                    print("Error while fetching remote rooms: \(response.result.error)")
//                    completion(nil)
//                    return
//                }
//                
//                print(response.result)
//
//                guard let value = response.result.value as? [String: Any],
//                    let rows = value["rows"] as? [[String: Any]] else {
//                        print("Malformed data received from fetchAllRooms service")
//                        completion(nil)
//                        return
//                }
//
//                completion(true)
//        }
//    }
}
