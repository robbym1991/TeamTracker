//
//  RegisterStepThreeController.swift
//  teamtracker
//
//  Created by Robby Michels on 15-03-18.
//  Copyright © 2018 Robby Michels. All rights reserved.
//

import Foundation
import UIKit

class RegisterStepThreeController: UIViewController {
    @IBOutlet weak var successTextLbl: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupText()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.statusBarStyle = .default
    }
    
    @IBAction func onClick(_ sender: Any) {
        performSegue(withIdentifier: SegueConstants.stepThreeToLoginSegue, sender: self)
    }
    
    func setupText() {
        successTextLbl.text = StringConstants.registerStepThreeView.successMessage.rawValue
        loginButton.setTitle(StringConstants.registerStepThreeView.buttonText.rawValue, for: .normal)
        loginButton.roundButtonCorners()
        loginButton.backgroundColor = Colors.secondaryColor
    }
}
