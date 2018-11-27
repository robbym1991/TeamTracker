//
//  InputHandler.swift
//  teamtracker
//
//  Created by Robby Michels on 18-03-18.
//  Copyright © 2018 Robby Michels. All rights reserved.
//

import Foundation
import UIKit

struct InputHandler {
    private static var hasError: Bool = false
    
    static func isInputEmpty(inputFields: [UITextField], errorLabel: UILabel) -> Bool {
        hasError = false
        errorLabel.text = ""
        Styling.resetBorderColorOnAll(textfields: inputFields)
        for inputfield in inputFields {
            if((inputfield.text?.isEmpty)! || (inputfield.text?.contains(""))!) {
                // Save error messages in localization later...
                ErrorMessage.setErrorMessage(label: errorLabel, message: StringConstants.emptyTextfield)
                Styling.errorBorderColor(textfield: inputfield)
                self.hasError = true
            }
        }
        
        return hasError
    }
    
    static func isInputInteger(inputfields: [UITextField], errorLbl: UILabel) -> Bool {
        hasError = false
        errorLbl.text = ""
        for field in inputfields {
            if(!isInputNumeric(input: field.text!)) {
                ErrorMessage.setErrorMessage(label: errorLbl, message: StringConstants.numericInput)
                Styling.errorBorderColor(textfield: field)
                self.hasError = true
            }
        }
        return hasError
    }
    
    static func isInputNumeric(input: String) -> Bool {
        return Double(input) != nil
    }
}
