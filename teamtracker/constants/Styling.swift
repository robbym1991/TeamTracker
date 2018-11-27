//
//  Styling.swift
//  teamtracker
//
//  Created by Robby Michels on 15-02-18.
//  Copyright © 2018 Robby Michels. All rights reserved.
//

import Foundation
import UIKit

//in this file all styling will be handled.
struct Styling {
    static let cornerRadius: CGFloat = 5.0
    static let graphBarWidth: CGFloat = 50
    
    //this will create rounded corners on the textfield.
    static func roundTextfieldCorners(textfield: UITextField) {
        textfield.layer.cornerRadius = cornerRadius
    }
    
    static func textfieldCornersOnAll(textfields: [UITextField]) {
        for textfield in textfields {
            textfield.layer.cornerRadius = cornerRadius
        }
    }
    
    static func resetBorderColor(textfield: UITextField) {
        textfield.layer.borderWidth = 0.0
    }
    
    static func resetBorderColorOnAll(textfields: [UITextField]) {
        for textfield in textfields {
            textfield.layer.borderWidth = 0.0
        }
    }
    
    static func emptyTextfields(textfields: [UITextField]) {
        for textfield in textfields {
            textfield.text = ""
        }
    }
    
    //this will set the border color, based on being focussed or not.
    static func changeBorderColor(textfield: UITextField, error: Bool) {
        if (textfield.layer.borderColor == Colors.highlightText.cgColor) {
            textfield.layer.borderColor = Colors.secondaryColor.cgColor
            textfield.layer.borderWidth = 0.0
        } else if(!error) {
            textfield.layer.borderColor = Colors.highlightText.cgColor
            textfield.layer.borderWidth = 2.0
        }
    }
    
    static func errorBorderColor(textfield: UITextField) {
        textfield.layer.borderColor = Colors.error.cgColor
        textfield.layer.borderWidth = 2.0
    }
    
    //this will create round corners on the button.
    static func roundButtonCorners(button: UIButton) {
        button.layer.cornerRadius = cornerRadius
    }
    
    static func setButtonColor(button: UIButton, color: UIColor) {
        button.backgroundColor = color
    }
    
    static func greyBorderColor(view: UIView) {
        view.layer.borderWidth = 2
        view.layer.borderColor = Colors.lightGrey.cgColor
    }
    
    static func setUINavbar(navigationBar: UINavigationBar) {
        UINavigationBar.appearance().barTintColor = .black
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        UINavigationBar.appearance().isTranslucent = false
    }
    
    static func setViewBackground(view: UIView, color: UIColor) {
        view.backgroundColor = color
    }
    
    static func roundViewCorners(view: UIView) {
        view.layer.cornerRadius = cornerRadius
    }
    
    static func setColorsInString(label: UILabel, string: String, stringLocation: Int, StringLength: Int) {
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: string, attributes: [NSAttributedStringKey.font:UIFont(name: "Montserrat-SemiBold", size: 17.0)!])
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: Colors.highlightText, range: NSRange(location: stringLocation, length: StringLength))
        label.attributedText = myMutableString
    }
    
    static func roundViewCornersLeft(view: UIView) {
        view.clipsToBounds = true
        view.layer.cornerRadius = cornerRadius
    }
    
    static func viewBorder(view: UIView) {
        view.layer.borderColor = Colors.textBlack.cgColor
        view.layer.borderWidth = 1
    }
    
    static func viewShadow(view: UIView) {
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 10
    }
    
    static func roundImageView(imageview: UIImageView) {
        imageview.layer.borderWidth = 1
        imageview.layer.masksToBounds = false
        imageview.layer.borderColor = UIColor.black.cgColor
        imageview.layer.cornerRadius = imageview.frame.height/2
        imageview.clipsToBounds = true
    }
    
    static func setButtonsInactive(buttons: [UIButton]) {
        for button in buttons {
            button.isEnabled = false
            button.backgroundColor = Colors.lightGrey
        }
    }
    
    static func setButtonsActive(buttons: [UIButton]) {
        for button in buttons {
            button.isEnabled = true
            button.backgroundColor = Colors.secondaryColor
        }
    }
    
    // This will remove the text from the bottom navigation bar.
    static func removeTabbarItemsText(tabbarItems: [UITabBarItem]) {
        for item in tabbarItems {
            item.title = ""
            item.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0)
        }
    }
}
