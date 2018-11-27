//
//  RegisterStepTwoController.swift
//  teamtracker
//
//  Created by Robby Michels on 13-03-18.
//  Copyright © 2018 Robby Michels. All rights reserved.
//

import Foundation
import UIKit

class RegisterStepTwoController: UIViewController {
    
    //email from register step one
    var email: String?
    var referralCode: String?
    var textfieldArray = [UITextField]()
    
    @IBOutlet weak var passwordConfirmLbl: UILabel!
    @IBOutlet weak var passwordLbl: UILabel!
    @IBOutlet weak var lastnameLbl: UILabel!
    @IBOutlet weak var firstnameLbl: UILabel!
    @IBOutlet weak var accountLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var stepOneView: UIView!
    @IBOutlet weak var stepTwoView: UIView!
    @IBOutlet weak var stepThreeView: UIView!
    
    @IBOutlet weak var stepOneLbl: UILabel!
    @IBOutlet weak var stepTwoLbl: UILabel!
    @IBOutlet weak var stepThreeLbl: UILabel!
    @IBOutlet weak var registerTextLbl: UILabel!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginLbl: UILabel!
    @IBOutlet weak var errorLbl: UILabel!
    
    @IBOutlet weak var firstnameTxtFld: UITextField!
    @IBOutlet weak var lastnameTxtFld: UITextField!
    @IBOutlet weak var passwordTxtFld: UITextField!
    @IBOutlet weak var passwordAgainTxtFld: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.statusBarStyle = .default
    }
    
    // onclick function checking inputs by user, and registering an account when all inputs are valid.
    @IBAction func onClick(_ sender: Any) {
        let loadingIndicator = UIViewController.displaySpinner(onView: self.view)

        Styling.resetBorderColorOnAll(textfields: textfieldArray)
        
        if(InputHandler.isInputEmpty(inputFields: textfieldArray, errorLabel: errorLbl)){
            // one or more input fields are empty
            UIViewController.removeSpinner(spinner: loadingIndicator)

            return
        }
        
        if((passwordTxtFld.text?.count)! < 6 || (passwordAgainTxtFld.text?.count)! < 6) {
            Styling.errorBorderColor(textfield: passwordTxtFld)
            Styling.errorBorderColor(textfield: passwordAgainTxtFld)
            ErrorMessage.setErrorMessage(label: errorLbl, message: "Password has to contain at least 6 characters")
            UIViewController.removeSpinner(spinner: loadingIndicator)

            return
        }
        
        if(!(passwordTxtFld.text!.elementsEqual(passwordAgainTxtFld.text!))) {
            Styling.errorBorderColor(textfield: passwordTxtFld)
            Styling.errorBorderColor(textfield: passwordAgainTxtFld)
            ErrorMessage.setErrorMessage(label: errorLbl, message: "Passwords have to match with eachother")
            UIViewController.removeSpinner(spinner: loadingIndicator)

            return
        }
        
        let registerAccount = Register(firstname: (firstnameTxtFld?.text)!,lastname: (lastnameTxtFld?.text)!, email: self.email!, password: (passwordTxtFld?.text)!,
                                    referralCode: self.referralCode!)
        
        let userDataHandler = UserDataHandler(email: "", referralCode: "")
        
        userDataHandler.registerAthlete(athlete: registerAccount) { (result) in
            UIViewController.removeSpinner(spinner: loadingIndicator)

            switch result {
                case .Success:
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: SegueConstants.stepTwoToStepThreeSegue, sender: self)
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
    
    //Add the email of the user with the existing text, and changing the color of the email part.
    func setupRegisterText() {
        let text = registerTextLbl.text
        let newString: String = text! + " " + email!
        let StringLocationStart: Int = (text?.count)!
        Styling.setColorsInString(label: registerTextLbl, string: newString, stringLocation: StringLocationStart, StringLength: ((email?.count)! + 1) )
    }
    
    @objc func onClickLoginLabel(sender: UITapGestureRecognizer) {
        // go back to the login page.
        performSegue(withIdentifier: SegueConstants.stepTwoToLoginSegue, sender: self)
    }
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func setupTapRecognization() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(RegisterStepTwoController.onClickLoginLabel))
        loginLbl.isUserInteractionEnabled = true
        loginLbl.addGestureRecognizer(tap)
        
        let keyboardTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RegisterStepTwoController.dismissKeyboard))
        view.addGestureRecognizer(keyboardTap)
    }
    
    func setupTxtFldArray() {
        textfieldArray.insert(firstnameTxtFld, at: 0)
        textfieldArray.insert(lastnameTxtFld, at: 1)
        textfieldArray.insert(passwordTxtFld, at: 2)
        textfieldArray.insert(passwordAgainTxtFld, at: 3)
    }
    
    func setupStyling() {
        Styling.roundViewCorners(view: stepOneView)
        Styling.roundViewCorners(view: stepTwoView)
        Styling.roundViewCorners(view: stepThreeView)
        Styling.roundButtonCorners(button: registerButton)
        Styling.greyBorderColor(view: stepThreeView)
        Styling.setViewBackground(view: stepOneView, color: Colors.highlightText)
        Styling.setViewBackground(view: stepTwoView, color: Colors.highlightText)
        Styling.setButtonColor(button: registerButton, color: Colors.secondaryColor)
        Styling.textfieldCornersOnAll(textfields: textfieldArray)
        setupText()
    }
    
    func setupText() {
        titleLbl.text = StringConstants.registerStepTwoView.title.rawValue
        accountLbl.text = StringConstants.registerStepTwoView.account.rawValue
        loginLbl.text = StringConstants.registerStepTwoView.login.rawValue
        registerTextLbl.text = StringConstants.registerStepTwoView.registerText.rawValue
        firstnameLbl.text = StringConstants.registerStepTwoView.firstname.rawValue
        lastnameLbl.text = StringConstants.registerStepTwoView.lastname.rawValue
        passwordLbl.text = StringConstants.registerStepTwoView.password.rawValue
        passwordConfirmLbl.text = StringConstants.registerStepTwoView.passwordConfirm.rawValue
        registerButton.setTitle(StringConstants.registerStepTwoView.buttonText.rawValue, for: .normal)
    }
    
    func setupUI() {
        setupTxtFldArray()
        setupStyling()
        setupTapRecognization()
        setupRegisterText()
    }
}
