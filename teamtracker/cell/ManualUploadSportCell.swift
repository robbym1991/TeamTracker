//
//  ManualUploadSportCell.swift
//  teamtracker
//
//  Created by Robby Michels on 17-05-18.
//  Copyright © 2018 Robby Michels. All rights reserved.
//

import UIKit

class ManualUploadSportCell: UICollectionViewCell {
    @IBOutlet weak var sportLbl: Label!
    @IBOutlet weak var sportImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(sportDescription: String, sportImage: UIImage) {
        self.sportImage.image = sportImage
        self.sportLbl.text = sportDescription
        self.sportLbl.backgroundColor = Colors.darkGrey
    }
}
