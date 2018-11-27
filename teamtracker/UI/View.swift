//
//  View.swift
//  teamtracker
//
//  Created by Robby Michels on 29-03-18.
//  Copyright © 2018 Robby Michels. All rights reserved.
//

import Foundation
import UIKit

class View: UIView {}

extension UIView {
    func gradientBackground(startColor: UIColor, endColor: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.cornerRadius = Styling.cornerRadius
        gradientLayer.locations = [0.4]
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y:0.0)
        
        // Use locations to delay the begining of color gradient. 0.5 means start at 50% of the screen.
        // gradientLayer.locations = [ 0.5 ]

        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]

        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func gradientBackgroundWithoutCornerRadius(startColor: UIColor, endColor: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.name = Identifier.gradientLayer
        gradientLayer.frame = bounds
        gradientLayer.locations = [0.4]
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y:0.0)
        
        // Use locations to delay the begining of color gradient. 0.5 means start at 50% of the screen.
        // gradientLayer.locations = [ 0.5 ]
        
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func gradientBackgroundRightRoundCorner(startColor: UIColor, endColor: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.name = Identifier.gradientLayer
        gradientLayer.frame = bounds
        gradientLayer.locations = [0.4]
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y:0.0)
        
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        
        let pathWithRadius = UIBezierPath(roundedRect:bounds, byRoundingCorners:[.topRight, .bottomRight], cornerRadii: CGSize(width: Styling.cornerRadius, height: Styling.cornerRadius))
        let shape = CAShapeLayer()
        shape.path = pathWithRadius.cgPath
        gradientLayer.mask = shape
        layer.mask = shape
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func roundViewCorners() {
        layer.cornerRadius = Styling.cornerRadius
    }
    
    func viewBorder() {
        layer.borderColor = Colors.textBlack.cgColor
        layer.borderWidth = 1
    }
    
    func viewShadow() {
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 10
    }
    
    func roundCornersLeft() {
        let rectShape = CAShapeLayer()
        rectShape.bounds = frame
        rectShape.position = center
        rectShape.path = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.bottomLeft , .topLeft], cornerRadii: CGSize(width: Styling.cornerRadius, height: Styling.cornerRadius)).cgPath
        
        //Here I'm masking the textView's layer with rectShape layer
        layer.mask = rectShape
    }
    
    func roundCornersRight() {
        let rectShape = CAShapeLayer()
        rectShape.bounds = frame
        rectShape.position = center
        rectShape.path = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.bottomRight , .topRight], cornerRadii: CGSize(width: Styling.cornerRadius, height: Styling.cornerRadius)).cgPath
        
        //Here I'm masking the textView's layer with rectShape layer
        layer.mask = rectShape
    }
}
