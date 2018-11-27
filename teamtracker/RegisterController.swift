//
//  RegisterController.swift
//  teamtracker
//
//  Created by Robby Michels on 07-03-18.
//  Copyright © 2018 Robby Michels. All rights reserved.
//

import Foundation
import UIKit

class RegisterController: UIViewController {
    @IBOutlet weak var trainerDescriptionLbl: Label!
    @IBOutlet weak var trainerLbl: Label!
    @IBOutlet weak var sporterDescriptionLbl: Label!
    @IBOutlet weak var sporterLbl: Label!
    @IBOutlet weak var accountLbl: Label!
    @IBOutlet weak var titleLbl: Label!
    @IBOutlet weak var coachView: UIView!
    @IBOutlet weak var athleteView: UIView!
    @IBOutlet weak var loginLbl: Label!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupStyling()
        
        //adding objective-c functionalities to the login lbl, and a gesture to remove the keyboard when tapping outside the keyboard.
        let tap = UITapGestureRecognizer(target: self, action: #selector(RegisterController.onClickLoginLbl))
        let tapAthleteView = UITapGestureRecognizer(target: self, action: #selector(RegisterController.onClickAthleteView))
        let tapCoachView = UITapGestureRecognizer(target: self, action: #selector(RegisterController.onClickCoachView))
        let keyboardTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RegisterController.dismissKeyboard))
        
        coachView.addGestureRecognizer(tapCoachView)
        athleteView.addGestureRecognizer(tapAthleteView)
        loginLbl.isUserInteractionEnabled = true
        loginLbl.addGestureRecognizer(tap)
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
    
    @objc func onClickCoachView(sender: UITapGestureRecognizer) {
        // show a popup/page that says that this option is not yet available.
    }
    
    @objc func onClickAthleteView(sender: UITapGestureRecognizer) {
        // change to the register page for athletes.
        performSegue(withIdentifier: SegueConstants.registerToStepOneSegue, sender: self)
    }
    
    @objc func onClickLoginLbl(sender: UITapGestureRecognizer) {
        // go back to the login page.
        performSegue(withIdentifier: SegueConstants.registerToLoginSegue, sender: self)
    }
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func setupStyling() {
        Styling.roundViewCorners(view: coachView)
        Styling.roundViewCorners(view: athleteView)
        athleteView.backgroundColor = Colors.highlightText
        coachView.backgroundColor = Colors.secondaryColor
        setupText()
    }
    
    func setupText() {
        titleLbl.text = StringConstants.registerView.title.rawValue
        accountLbl.text = StringConstants.registerView.accountLbl.rawValue
        loginLbl.text = StringConstants.registerView.loginLbl.rawValue
        sporterLbl.text = StringConstants.registerView.athleteLbl.rawValue
        sporterDescriptionLbl.text = StringConstants.registerView.athleteDescription.rawValue
        trainerLbl.text = StringConstants.registerView.trainerLbl.rawValue
        trainerDescriptionLbl.text = StringConstants.registerView.trainerDescription.rawValue
    }
}
