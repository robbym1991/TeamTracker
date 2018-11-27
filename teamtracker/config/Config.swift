//
//  Config.swift
//  teamtracker
//
//  Created by Robby Michels on 21-02-18.
//  Copyright © 2018 Robby Michels. All rights reserved.
//

import Foundation

struct Config {
    // TODO: Change this to enum so its more structured.
    static let clientToken = "eklkjvb;ibcsfSDGVSDGVnsduivbjhsdbvkjbrwkj"
    static let apiURL = "http://127.0.0.1:8000/api"
    static let apiLogin = "/login"
    static let apiRegister = "/register"
    static let apiInvite = "/invite"
    static let apiValidateInvite = "/invite/validate"
    static let apiRegisterByInvite = "/register/by-invite"
    static let apiForgotPassword = "/password/email"
    static let createActivity = "/activity/create"
    static let getUserActivity = "/activity/user"
}
