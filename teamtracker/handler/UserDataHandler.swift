//
//  UserDataHandler.swift
//  teamtracker
//
//  Created by Robby Michels on 22-02-18.
//  Copyright © 2018 Robby Michels. All rights reserved.
//

import Foundation
import UIKit

class UserDataHandler {
    let email: String
    let password: String
    let referralCode: String
    let loginComplete: Bool = true
    
    enum Results<T> {
        case Success()
        case Error(String)
    }
    
    init(email: String) {
        self.email = email
        self.password = ""
        self.referralCode = ""
    }
    
    init(email: String, referralCode: String) {
        self.email = email
        self.password = ""
        self.referralCode = referralCode
    }
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
        self.referralCode = ""
    }
    
    func handleLogin(completion: @escaping (Results<[String: Any]>) -> Void) -> Void {
        UserProvider.login(email: email, password: password) { (output) in
            switch output {
                case .Error(let errorMsg) :
                    completion(.Error(errorMsg))
                case .Success(let json) :
                    // Cache data here..
                    let successobject = json["success"] as! [String: Any]
                    let user = successobject["user"] as! [String: Any]
                        
                    let firstname = user["first_name"] as! String
                    let lastname = user["last_name"] as! String
                    let roleType = user["role_type"] as! String
                    let avatarLink = user["avatar"] as! String
                    
                    let fullname = firstname + " " + lastname
                    
                    let defaults = UserDefaults.standard
                    defaults.set(successobject["token"], forKey: StringConstants.defaultsKeys.bearerToken.rawValue)
                    defaults.set(fullname, forKey: StringConstants.defaultsKeys.fullname.rawValue)
                    defaults.set(roleType, forKey: StringConstants.defaultsKeys.roleType.rawValue)
                    defaults.set(avatarLink, forKey: StringConstants.defaultsKeys.avatarLink.rawValue)
        
                    completion(.Success())
                case .EmptySuccess() :
                    completion(.Success())
            }
        }
    }

    func validateInvite(completion: @escaping (Results<[String: Any]>) -> Void) -> Void {
        UserProvider.validateInviteCodeEmail(email: email, uniqueTeamcode: referralCode) { (result) in
            switch result {
                case .Success(_) :
                    completion(.Success())
                case .EmptySuccess() :
                    completion(.Success())
                case .Error(let errorMsg):
                    completion(.Error(errorMsg))
            }
        }
    }
    
    func registerAthlete(athlete: Register, completion: @escaping (Results<[String: Any]>) -> Void) -> Void {
        UserProvider.registerAthlete(registerAccount: athlete) { (result) in
            switch result {
                case .Success(_):
                    completion(.Success())
                case .EmptySuccess:
                    completion(.Success())
                case .Error(let errorMsg):
                    completion(.Error(errorMsg))
            }
        }
    }
    
    func forgotPassword(completion: @escaping (Results<[String: Any]>) -> Void) -> Void {
        UserProvider.forgotPassword(email: self.email) { (result) in
            switch result {
                case .Success(_):
                    completion(.Success())
                case .EmptySuccess:
                    completion(.Success())
                case .Error(let errorMsg):
                    completion(.Error(errorMsg))
            }
        }
    }
    
    func activityUpload(sport: String, title: String, type: String, date: String, time: String, description: String, distance: String, durationHour: String, durationMin: String, durationSeconds: String, elevation: String, tss: String, completion: @escaping (Results<[String: Any]>) -> Void ) -> Void {
        UserProvider.uploadActivity(sport: sport, title: title, type: type, date: date, time: time + ":00", description: description, distance: distance, durationHour: durationHour, durationMin: durationMin, durationSeconds: durationSeconds, elevation: elevation, tss: tss) { (result) in
            switch result {
                case .Success(_):
                    completion(.Success())
                case .EmptySuccess:
                    completion(.Success())
                case .Error(let errorMsg):
                    completion(.Error(errorMsg))
            }
        }
    }
}
