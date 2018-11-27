//
//  File.swift
//  teamtracker
//
//  Created by Robby Michels on 16-03-18.
//  Copyright © 2018 Robby Michels. All rights reserved.
//

import Foundation
import UIKit

struct ErrorMessage {
    static func setErrorMessage(label: UILabel, message: String) {
        label.textColor = Colors.error
        label.text = message
    }
}
