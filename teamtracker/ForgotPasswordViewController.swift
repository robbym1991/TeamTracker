//
//  ForgotPasswordViewController.swift
//  teamtracker
//
//  Created by Robby Michels on 19-04-18.
//  Copyright © 2018 Robby Michels. All rights reserved.
//

import Foundation
import UIKit

class ForgotPasswordViewController: UIViewController {
    var inputfields = [UITextField]()
    var buttons = [UIButton]()
    var userDataHandler: UserDataHandler?
    
    @IBOutlet weak var cancelButton: Button!
    @IBOutlet weak var nextButton: Button!
    
    @IBOutlet weak var errorLbl: UILabel!
    @IBOutlet weak var viewTitle: UILabel!
    @IBOutlet weak var viewSubTitle: UILabel!
    @IBOutlet weak var emailTextFieldLbl: UILabel!
    
    @IBOutlet weak var emailTextField: TextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyling()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.statusBarStyle = .default
    }
    
    @IBAction func onClickCancel(_ sender: Any) {
        // dismiss the current view.
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onClickSend(_ sender: Any) {
        let loadingIndicator = UIViewController.displaySpinner(onView: self.view)

        //show user something is happening.
        buttons.append(cancelButton)
        buttons.append(nextButton)
        Styling.setButtonsInactive(buttons: buttons)
        
        inputfields.append(emailTextField)
        
        // Check for empty inputfields
        if(!InputHandler.isInputEmpty(inputFields: self.inputfields, errorLabel: self.errorLbl)) {
            // Check if email is valid.
            if(Regexp.isEmailValid(email: emailTextField.text!)) {
                //make api request to reset password.
                self.userDataHandler = UserDataHandler(email: emailTextField.text!)
                // Make API Call
                self.userDataHandler?.forgotPassword() { (result) in
                    UIViewController.removeSpinner(spinner: loadingIndicator)
                    // Respond based on result.
                    switch result {
                        case .Error(let errorMsg) :
                            DispatchQueue.main.async {
                                ErrorMessage.setErrorMessage(label: self.errorLbl, message: errorMsg)
                                Styling.setButtonsActive(buttons: self.buttons)

                                return
                        }
                        case .Success():
                            DispatchQueue.main.async {
                                self.performSegue(withIdentifier: SegueConstants.forgotPasswordToSuccessSegue, sender: self)
                                return
                        }
                    }
                }
            } else {
                // Set error, and reactivate buttons.
                ErrorMessage.setErrorMessage(label: self.errorLbl, message: StringConstants.nonValidEmail)
                Styling.errorBorderColor(textfield: emailTextField)
                Styling.setButtonsActive(buttons: buttons)
                UIViewController.removeSpinner(spinner: loadingIndicator)

            }
        } else {
            // Reactivate buttons.
            Styling.setButtonsActive(buttons: buttons)
            UIViewController.removeSpinner(spinner: loadingIndicator)
            
        }
    }
    
    //This will be run before any performSegue()
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == SegueConstants.forgotPasswordToSuccessSegue) {
            if let nextViewController = segue.destination as? SuccessForgotPasswordViewController {
                //filling the email variable of the next view.
                nextViewController.email = emailTextField.text!
            }
        }
    }
    
    // Set all UIStyling.
    func setStyling() {
        cancelButton.backgroundColor = Colors.secondaryColor
        nextButton.backgroundColor = Colors.secondaryColor
        
        cancelButton.roundButtonCorners()
        nextButton.roundButtonCorners()
        
        cancelButton.setTitle(StringConstants.cancel, for: .normal)
        nextButton.setTitle(StringConstants.next, for: .normal)
        
        viewTitle.text = StringConstants.forgotPasswordTitle
        viewSubTitle.text = StringConstants.forgotPasswordSubtitle
        
        emailTextFieldLbl.text = StringConstants.email
    }
    
}
