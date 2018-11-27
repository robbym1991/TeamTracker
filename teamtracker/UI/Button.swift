//
//  Button.swift
//  teamtracker
//
//  Created by Robby Michels on 24-04-18.
//  Copyright © 2018 Robby Michels. All rights reserved.
//

import Foundation
import UIKit

class Button: UIButton {
    
}

extension UIButton {
    // Create round corners on the button.
    func roundButtonCorners() {
        layer.cornerRadius = Styling.cornerRadius
    }
    
    func setButtonClickedState() {
        gradientBackgroundWithoutCornerRadius(startColor: Colors.blue, endColor: Colors.lightBrightGreen)
        setTitleColor(Colors.white, for: UIControlState.normal)
    }
    
    func setButtonInactive() {
        isEnabled = false
        backgroundColor = Colors.lightGrey
    }

    func setButtonsActive() {
        isEnabled = true
        backgroundColor = Colors.secondaryColor
    }
    
    func setErrorBorder() {
        layer.borderColor = UIColor.red.cgColor
        layer.borderWidth = 1
    }
    
    func clearBorderColor() {
        layer.borderWidth = 0
    }
    
    func setButtonNormalState() {
        for layer in layer.sublayers! {
            if layer.name == Identifier.gradientLayer {
                layer.removeFromSuperlayer()
            }
        }
        setTitleColor(Colors.greyTextColor, for: UIControlState.normal)
    }
}
