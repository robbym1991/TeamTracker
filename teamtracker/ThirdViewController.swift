//
//  ThirdViewController.swift
//  teamtracker
//
//  Created by Robby Michels on 29-03-18.
//  Copyright © 2018 Robby Michels. All rights reserved.
//

import Foundation
import UIKit

class ThirdViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Change title if needed, not sure which screen comes where.
        self.navigationItem.title = StringConstants.viewTitles.ThirthView.rawValue
        
        setUIStyling()
    }
    
    func setUIStyling() {
        Styling.removeTabbarItemsText(tabbarItems: (tabBarController?.tabBar.items)!)
    }
}
