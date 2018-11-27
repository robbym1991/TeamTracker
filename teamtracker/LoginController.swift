//
//  LoginController.swift
//  teamtracker
//
//  Created by Robby Michels on 13-02-18.
//  Copyright © 2018 Robby Michels. All rights reserved.
//

import Foundation
import UIKit

class LoginController: UIViewController {
    @IBOutlet weak var errorLbl: UILabel!
    @IBOutlet weak var emailTextField: UITextField?
    @IBOutlet weak var passwordTextField: UITextField?
    @IBOutlet weak var loginButton: UIButton?
    @IBOutlet weak var inloggenLbl: UILabel!
    @IBOutlet weak var passwordForgottenLbl: UILabel!
    @IBOutlet weak var registerLbl: UILabel!
    @IBOutlet weak var noAccountLbl: UILabel!
    @IBOutlet weak var emailLbl: Label!
    @IBOutlet weak var passwordLbl: Label!
    
    var userDataHandler: UserDataHandler?
    var error: Bool = false
    var inputfields = [UITextField]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupStyling()
        let tap = UITapGestureRecognizer(target: self, action: #selector(LoginController.onClickRegister))
        let keyboardTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginController.dismissKeyboard))
        let passwordForgotten = UITapGestureRecognizer(target: self, action: #selector(LoginController.forgottenPassword))
        
        registerLbl.isUserInteractionEnabled = true
        passwordForgottenLbl.isUserInteractionEnabled = true
        
        registerLbl.addGestureRecognizer(tap)
        passwordForgottenLbl.addGestureRecognizer(passwordForgotten)
        view.addGestureRecognizer(keyboardTap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.statusBarStyle = .default
    }
    
    @objc func forgottenPassword() {
        self.performSegue(withIdentifier: SegueConstants.loginToForgotPasswordSegue, sender: self)
    }

    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    //this triggers when the login button is clicked
    @IBAction func onClick(_ sender: Any) {
        let loadingIndicator = UIViewController.displaySpinner(onView: self.view)
        //TODO: check for internet connection
        inputfields.append(emailTextField!)
        inputfields.append(passwordTextField!)
        let email = emailTextField?.text
        let password = passwordTextField?.text
        self.userDataHandler = UserDataHandler(email: email!, password: password!)
        
        // maybe change to: checkInputs(inputField: [UITextfield])
        if(InputHandler.isInputEmpty(inputFields: inputfields, errorLabel: errorLbl)){
            // one or more input fields are empty
            UIViewController.removeSpinner(spinner: loadingIndicator)
            return
        }
        
        if(!Regexp.isEmailValid(email: (emailTextField?.text)!)) {
            // TODO: add error message to localization later...
            ErrorMessage.setErrorMessage(label: errorLbl, message: "Please enter a valid email...")
            UIViewController.removeSpinner(spinner: loadingIndicator)
            return
        }
        
        self.userDataHandler?.handleLogin() { (result) in
            UIViewController.removeSpinner(spinner: loadingIndicator)
            
            switch result {
                case .Error(let errorMsg) :
                    DispatchQueue.main.async {
                        ErrorMessage.setErrorMessage(label: self.errorLbl, message: errorMsg)
                        return
                    }
                case .Success():
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: SegueConstants.loginToHome, sender: self)
                        return
                    }
            }
        }
    }
    
    @objc func onClickRegister(sender:UITapGestureRecognizer) {
        performSegue(withIdentifier: SegueConstants.loginToRegister, sender: self)
    }

    @IBAction func emailEditingDidBegin(_ sender: Any) {
        Styling.changeBorderColor(textfield: emailTextField!, error: self.error)
    }
    
    @IBAction func emailEditingDidEnd(_ sender: Any) {
        Styling.changeBorderColor(textfield: emailTextField!, error: self.error)
    }
    
    
    @IBAction func passwordEditingDidBegin(_ sender: Any) {
        Styling.changeBorderColor(textfield: passwordTextField!, error: self.error)
    }
    
    @IBAction func passwordEditingDidEnd(_ sender: Any) {
        Styling.changeBorderColor(textfield: passwordTextField!, error: self.error)
    }
    
    func setupStyling() {
        emailTextField?.backgroundColor = Colors.lightGrey
        passwordTextField?.backgroundColor = Colors.lightGrey
        
        passwordTextField?.textColor = Colors.secondaryTextBlack
        emailTextField?.textColor = Colors.secondaryTextBlack
        
        Styling.roundTextfieldCorners(textfield: emailTextField!)
        Styling.roundTextfieldCorners(textfield: passwordTextField!)
        Styling.roundButtonCorners(button: loginButton!)
        
        loginButton?.backgroundColor = Colors.secondaryColor
        inloggenLbl.textColor = Colors.textBlack
        passwordForgottenLbl.textColor = Colors.secondaryColor
        registerLbl.textColor = Colors.highlightText
        noAccountLbl.textColor = Colors.secondaryTextBlack
        
        setupText()
    }
    
    func setupText() {
        inloggenLbl.text = StringConstants.loginView.title.rawValue
        noAccountLbl.text = StringConstants.loginView.noAccount.rawValue
        registerLbl.text = StringConstants.loginView.register.rawValue
        emailLbl.text = StringConstants.loginView.email.rawValue
        passwordLbl.text = StringConstants.loginView.password.rawValue
        passwordForgottenLbl.text = StringConstants.loginView.passwordForgotten.rawValue
        loginButton?.setTitle(StringConstants.loginView.title.rawValue, for: .normal)
    }
}
