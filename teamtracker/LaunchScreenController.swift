//
//  LaunchScreenController.swift
//  teamtracker
//
//  Created by Robby Michels on 31-05-18.
//  Copyright © 2018 Robby Michels. All rights reserved.
//

import Foundation
import UIKit
import Lottie

class LaunchScreenController: UIViewController {
    var destination: UIViewController?
    var logoImageView: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set both height and width at 75% of the devices width.
        let height: CGFloat = view.bounds.width * 0.75
        let width: CGFloat = view.bounds.width * 0.75
        let animationView = LOTAnimationView(name: StringConstants.launchscreenAnimation)
        animationView.frame = CGRect(x: (view.bounds.width / 2) - (width / 2), y: (view.bounds.height / 2) - (height / 2), width: width, height: height)
        self.view.addSubview(animationView)
        animationView.play{ (finished) in
            // When animation is done playing, segue too login.
            self.performSegue(withIdentifier: SegueConstants.launchscreenToLogin, sender: self)
        }
    }
}

