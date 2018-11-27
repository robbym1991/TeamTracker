//
//  Label.swift
//  teamtracker
//
//  Created by Robby Michels on 29-03-18.
//  Copyright © 2018 Robby Michels. All rights reserved.
//

import Foundation
import UIKit

class Label: UILabel{}

extension UILabel {
    func iconLeft(image: UIImage, initialString: String) {
        // Create Attachment
        let icon =  NSTextAttachment()
        icon.image = image.withRenderingMode(.alwaysTemplate)
    
        // let iconOffsetY:CGFloat = -5.0;
        icon.bounds = CGRect(x: 0, y: 0, width: 10, height: 10)
        // Create string with attachment
        let attachmentString = NSAttributedString(attachment: icon)
        // Initialize mutable string
        let completeText = NSMutableAttributedString(string: " ")
        //completeText.addAttribute(NSForegroundColorAttributeName, value: UIColor.white, range: NSMakeRange(0, 2))

        // Add image to mutable string
        completeText.append(attachmentString)
        // Add your text to mutable string
        let  textAfterIcon = NSMutableAttributedString(string: "    " + initialString)
        completeText.append(textAfterIcon)
        attributedText = completeText;
    
    }
}
