//
//  upcommingEventCell.swift
//  teamtracker
//
//  Created by Robby Michels on 17-04-18.
//  Copyright © 2018 Robby Michels. All rights reserved.
//

import Foundation
import UIKit

class UpcommingEventCell: UICollectionViewCell {
    @IBOutlet weak var containerView: View!
    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var eventDescription: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var dayDateView: View!
    @IBOutlet weak var eventDescriptionView: View!
}
