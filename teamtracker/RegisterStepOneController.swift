//
//  RegisterStepOneController.swift
//  teamtracker
//
//  Created by Robby Michels on 07-03-18.
//  Copyright © 2018 Robby Michels. All rights reserved.
//

import Foundation
import UIKit

class RegisterStepOneController: UIViewController {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var uniqueTeamCodeLbl: UILabel!
    @IBOutlet weak var accountLbl: Label!
    @IBOutlet weak var stepOneView: UIView!
    @IBOutlet weak var stepTwoView: UIView!
    @IBOutlet weak var stepThreeView: UIView!
    @IBOutlet weak var stepOneLbl: UILabel!
    @IBOutlet weak var stepTwoLbl: UILabel!
    @IBOutlet weak var stepThreeLbl: UILabel!
    @IBOutlet weak var registerTextLbl: UILabel!
    @IBOutlet weak var uniqueTeamCodeText: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginLbl: UILabel!
    @IBOutlet weak var errorLbl: UILabel!
    
    var inputfields = [UITextField]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStyling()
        setupTapRecognization()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.statusBarStyle = .default
    }
    
    // onclick method validating the users input when inputs aren't empty. When validating is succesfull,
    // the user will be redirected to the 2nd step.
    @IBAction func onClick(_ sender: Any) {
        let loadingIndicator = UIViewController.displaySpinner(onView: self.view)

        Styling.resetBorderColor(textfield: self.email)
        Styling.resetBorderColor(textfield: uniqueTeamCodeText)
        
        inputfields.append(self.uniqueTeamCodeText)
        inputfields.append(self.email)
        let uniqueCode = self.uniqueTeamCodeText.text
        let email = self.email.text
        
        if(InputHandler.isInputEmpty(inputFields: inputfields, errorLabel: errorLbl)){
            // one or more input fields are empty
            UIViewController.removeSpinner(spinner: loadingIndicator)

            return
        }
        
        if(!Regexp.isEmailValid(email: (email)!)) {
            Styling.errorBorderColor(textfield: self.email)
            ErrorMessage.setErrorMessage(label: errorLbl, message: "Please enter a valid email...")
            UIViewController.removeSpinner(spinner: loadingIndicator)

            return
        }
        
        let userDataHandler = UserDataHandler(email: (email?.lowercased())!, referralCode: uniqueCode!)
        
        //call validateinvite method, which will return a Bool based on the response code it will receive.
        userDataHandler.validateInvite() { (result) in
            UIViewController.removeSpinner(spinner: loadingIndicator)

            switch result {
             case .Success:
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: SegueConstants.steponeToSteptwoSegue, sender: self)
                    return
                }
            case .Error(let errorMsg):
                DispatchQueue.main.async {
                    ErrorMessage.setErrorMessage(label: self.errorLbl, message: errorMsg)
                    return
                }
            }
        }
    }
    
    //this gets run before going to next controller, send along the unique teamcode and the email.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == SegueConstants.steponeToSteptwoSegue) {
            if let nextViewController = segue.destination as? RegisterStepTwoController {
                //filling the email and referralCode variables with the email and referralCode filled in by user.
                nextViewController.email = self.email.text?.lowercased()
                nextViewController.referralCode = self.uniqueTeamCodeText.text
            }
        }
    }
    
    //Calls this function when the tap outside the keyboard is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @objc func onClickLoginLabel(sender: UITapGestureRecognizer) {
        // go back to the login page.
        performSegue(withIdentifier: SegueConstants.stepOneToLoginSegue, sender: self)
    }
    
    func setupTapRecognization() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(RegisterStepOneController.onClickLoginLabel))
        loginLbl.isUserInteractionEnabled = true
        loginLbl.addGestureRecognizer(tap)
        
        let keyboardTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RegisterStepOneController.dismissKeyboard))
        view.addGestureRecognizer(keyboardTap)
    }
    
    func setupStyling() {
        setupText()
        Styling.roundViewCorners(view: stepOneView)
        Styling.roundViewCorners(view: stepTwoView)
        Styling.roundViewCorners(view: stepThreeView)
        Styling.roundButtonCorners(button: registerButton)
        Styling.roundTextfieldCorners(textfield: uniqueTeamCodeText)
        Styling.roundTextfieldCorners(textfield: email)
        Styling.greyBorderColor(view: stepTwoView)
        Styling.greyBorderColor(view: stepThreeView)
        Styling.setViewBackground(view: stepOneView, color: Colors.highlightText)
        Styling.setButtonColor(button: registerButton, color: Colors.secondaryColor)
        Styling.setColorsInString(label: registerTextLbl, string: registerTextLbl.text!, stringLocation: 0, StringLength: 6)
    }
    
    func setupText() {
        titleLbl.text = StringConstants.registerStepOneView.title.rawValue
        accountLbl.text = StringConstants.registerStepOneView.account.rawValue
        loginLbl.text = StringConstants.registerStepOneView.login.rawValue
        registerTextLbl.text = StringConstants.registerStepOneView.registerText.rawValue
        uniqueTeamCodeLbl.text = StringConstants.registerStepOneView.uniqueTeamcode.rawValue
        emailLbl.text = StringConstants.registerStepOneView.email.rawValue
        registerButton.setTitle(StringConstants.registerStepOneView.buttonText.rawValue, for: .normal)
    }
}
