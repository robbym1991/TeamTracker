//
//  TextField.swift
//  teamtracker
//
//  Created by Robby Michels on 15-02-18.
//  Copyright © 2018 Robby Michels. All rights reserved.
//
import Foundation
import UIKit

//custom changes for UITextfield
class TextField: UITextField {
    
    let padding = UIEdgeInsets(top: 15, left: 20, bottom: 0, right: 5);
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
}
