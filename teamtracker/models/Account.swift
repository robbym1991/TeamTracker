//
//  Account.swift
//  teamtracker
//
//  Created by Robby Michels on 14-02-18.
//  Copyright © 2018 Robby Michels. All rights reserved.
//

import Foundation
import UIKit

//Account model.
class Account {
    private let email: String
    private let token: String
    private let firstname: String
    private let surname: String
    private let lastname: String
    private let fullname: String
    
    enum SerializationError:Error {
        case missing(String)
        case invalid(String, Any)
    }
    
    init(email: String, token: String, firstname: String, surname: String, lastname: String) {
        self.email = email
        self.token = token
        self.firstname = firstname
        self.surname = surname
        self.lastname = lastname
        fullname = firstname + (surname.contains("") == true ? " " : surname) + lastname
    }
    
    init(json: [String: Any]) throws {
        guard let email = json["email"] as? String else { throw SerializationError.missing("Email is missing")}
        guard let token = json["token"] as? String else { throw SerializationError.missing("token is missing") }
        guard let firstname = json["firstname"] as? String else { throw SerializationError.missing("Firstname is missing") }
        guard let surname = json["surname"] as? String else { throw SerializationError.missing("surname is missing") }
        guard let lastname = json["lastname"] as? String else { throw SerializationError.missing("lastname is missing") }
        
        self.email = email
        self.token = token
        self.firstname = firstname
        self.surname = surname
        self.lastname = lastname
        fullname = firstname + (surname.contains("") == true ? " " : surname) + lastname
    }
    
    
}
