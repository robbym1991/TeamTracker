//
//  UIViewController.swift
//  teamtracker
//
//  Created by Robby Michels on 31-05-18.
//  Copyright © 2018 Robby Michels. All rights reserved.
//

import Foundation
import UIKit

class ViewController: UIViewController {}

extension UIViewController {
    class func displaySpinner(onView: UIView) -> UIView {
        let spinnerView = UIView(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        return spinnerView
    }
    
    class func removeSpinner(spinner: UIView) {
        DispatchQueue.main.async {
            spinner.removeFromSuperview()
        }
    }
}
