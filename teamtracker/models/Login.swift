//
//  Login.swift
//  teamtracker
//
//  Created by Robby Michels on 13-02-18.
//  Copyright © 2018 Robby Michels. All rights reserved.
//
//
//import Foundation
//
//class Login {
//    var email: String
//    var password: String
//    
//    init(email: String, password: String) {
//        self.email = email
//        self.password = password
//    }
//    
//    static func login(email: String, password: String, completion: @escaping ([String: Any]) -> Void) -> Void {
//        //let param: [String: Any] = ["first_name": firstname, "last_name": lastname, "email": email, "password": password, "password_confirmation": password]
//        let param: String = "email=" + email + "&password=" + password
//        
//        print(param)
//        guard let url = URL(string: Config.apiURL + Config.apiLogin) else { return }
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.addValue("application/json", forHTTPHeaderField: "Accept")
//        request.httpBody = param.data(using: .utf8)
//        
//        let session = URLSession.shared
//        session.dataTask(with: request) { (data, response, error) in
//            if let response = response {
//                print(response)
//            }
//            
//            if let data = data {
//                do {
//                    guard let json = (try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers))
//                        as? [String: Any]
//                        else {
//                        print("Not containing JSON")
//                        return
//                    }
//                    completion(json)
//                } catch {
//                    print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& ", error)
//                }
//            }
//            
//        }.resume()
//    }
//}
