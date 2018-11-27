//
//  TextView.swift
//  teamtracker
//
//  Created by Robby Michels on 24-05-18.
//  Copyright © 2018 Robby Michels. All rights reserved.
//

import Foundation
import UIKit

class TextView: UITextView {}

extension UITextView {    
    func clearBorderColor() {
        layer.borderWidth = 0
    }
    
    func setErrorBorder() {
        layer.borderWidth = 1
        layer.borderColor = UIColor.red.cgColor
    }
}
