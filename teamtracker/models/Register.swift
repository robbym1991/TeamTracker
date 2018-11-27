//
//  Register.swift
//  teamtracker
//
//  Created by Robby Michels on 14-03-18.
//  Copyright © 2018 Robby Michels. All rights reserved.
//

import Foundation
import UIKit

class Register {
    let firstname: String
    let lastname: String
    let email: String
    let password: String
    let referralCode: String
    
    
    init(firstname: String, lastname: String, email: String, password: String, referralCode: String) {
        self.firstname = firstname
        self.lastname = lastname
        self.email = email
        self.password = password
        self.referralCode = referralCode
    }
    
    func getEmail() -> String {
        return self.email
    }
    
    func getFirstname() -> String {
        return self.firstname
    }
    
    func getLastname() -> String {
        return self.lastname
    }
    
    func getPassword() -> String {
        return self.password
    }
    
    func getReferralCode() -> String {
        return self.referralCode
    }
}
