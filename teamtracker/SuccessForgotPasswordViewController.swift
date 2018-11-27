//
//  SuccessForgotPasswordViewController.swift
//  teamtracker
//
//  Created by Robby Michels on 23-04-18.
//  Copyright © 2018 Robby Michels. All rights reserved.
//

import Foundation
import UIKit

class SuccessForgotPasswordViewController: UIViewController {
    @IBOutlet weak var successMessage: UILabel!
    @IBOutlet weak var successButton: Button!
    
    var email: String?
    
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
    
    func setSuccessMessage() {
        let message = StringConstants.forgotEmailSuccessMessage + " " + email!
        
        //Start location is where the recoloring of the string should begin, +1 because of the space.
        let startLocation: Int = (StringConstants.forgotEmailSuccessMessage.count + 1)
        Styling.setColorsInString(label: self.successMessage, string: message, stringLocation: startLocation, StringLength: (email?.count)!)
    }
    
    @IBAction func onClickButton(_ sender: Any) {
        self.performSegue(withIdentifier: SegueConstants.forgotPasswordSuccessScreenToLoginSegue, sender: self)
    }
    
    func setStyling() {
        successButton.roundButtonCorners()
        successButton.setTitle(StringConstants.backToLogin, for: .normal)
        successButton.backgroundColor = Colors.secondaryColor
        setSuccessMessage()
    }
}
