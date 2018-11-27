//
//  CollectionView.swift
//  teamtracker
//
//  Created by Robby Michels on 16-04-18.
//  Copyright © 2018 Robby Michels. All rights reserved.
//

import Foundation
import UIKit

class UpcommingEventCell: UICollectionViewCell {}

extension UpcommingEventCell : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    

        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "upcommingEvent", for: indexPath) as? UICollectionViewCell else { return UICollectionViewCell() }
            return cell
        }
        
    }
    
    extension UpcommingEventCell : UICollectionViewDelegateFlowLayout {
        
        private func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
            let itemsPerRow:CGFloat = 4
            let hardCodedPadding:CGFloat = 5
            let itemWidth = (collectionView.bounds.width / itemsPerRow) - hardCodedPadding
            let itemHeight = collectionView.bounds.height - (2 * hardCodedPadding)
            return CGSize(width: itemWidth, height: itemHeight)
        }
        
    }

