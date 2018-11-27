//
//  FourthViewController.swift
//  teamtracker
//
//  Created by Robby Michels on 02-05-18.
//  Copyright © 2018 Robby Michels. All rights reserved.
//

import Foundation
import UIKit

class FourthViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Change title if needed, not sure which screen comes where.
        self.navigationItem.title = StringConstants.viewTitles.Statistics.rawValue
        
        setUIStyling()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUIStyling() {
        Styling.removeTabbarItemsText(tabbarItems: (tabBarController?.tabBar.items)!)
    }
}
