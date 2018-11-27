//
//  regexp.swift
//  teamtracker
//
//  Created by Robby Michels on 16-02-18.
//  Copyright © 2018 Robby Michels. All rights reserved.
//

import Foundation
import UIKit

//use this file to save the functions to check regexp.
struct Regexp {
    private static let emailRegexpp = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    private static let dateRegexp = "^(19|20)\\d\\d[- /.](0[1-9]|1[012])[- /.](0[1-9]|[12][0-9]|3[01])$"
    private static let timeRegexp = "^([0-9]|0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]$"
    
    static func isEmailValid(email: String) -> Bool {
        let emailCheck = NSPredicate(format:"SELF MATCHES %@", emailRegexpp)
        return emailCheck.evaluate(with: email)
    }
    
    static func isDateValid(date: String) -> Bool {
        let dateCheck = NSPredicate(format: "SELF MATCHES %@", dateRegexp)
        return dateCheck.evaluate(with: date)
    }
    
    static func isTimeValid(time: String) -> Bool {
        let timeCheck = NSPredicate(format: "SELF MATCHES %@", timeRegexp)
        return timeCheck.evaluate(with: time)
    }
}
