//
//  User.swift
//  teamtracker
//
//  Created by Robby Michels on 22-02-18.
//  Copyright © 2018 Robby Michels. All rights reserved.
//

import Foundation
import UIKit

class User {
    var firstname: String
    var lastname: String
    var email: String
    var userToken: String
    var userID: Int
    var roleType: String
    
    init(json: [String: Any]) {
        let success = json["success"] as? [String: Any]
        let user = success!["user"] as? [String: Any]
        self.firstname = (user!["first_name"] as? String)!
        self.lastname = (user!["last_name"] as? String)!
        self.email = (user!["email"] as? String)!
        
        if let roletype = user!["role_type"] as? String { self.roleType = roletype } else { self.roleType = "" }
        
        self.userID = (user!["id"] as? Int)!
        self.userToken = (success!["token"] as? String)!
    }
    
    init(firstname: String, lastname: String, email: String, usertoken: String, userID: Int, roleType: String) {
        self.firstname = firstname
        self.lastname = lastname
        self.email = email
        self.userToken = usertoken
        self.roleType = roleType
        self.userID = userID
    }
    
    func getUserToken() -> String {
        return self.userToken
    }
}
