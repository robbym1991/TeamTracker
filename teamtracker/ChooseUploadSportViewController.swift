//
//  SecondViewController.swift
//  teamtracker
//
//  Created by Robby Michels on 07-02-18.
//  Copyright © 2018 Robby Michels. All rights reserved.
//

import UIKit

class ChooseUploadSportViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var viewDescription: UILabel!
    var estimatedWidth = 160.0
    var cellMarginSize = 16.0
    var chosenSport: String?
    var chosenSportIcon: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Set Delegates
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        // Register CollectionView Cell
        self.collectionView.register(UINib(nibName: Identifier.manualUploadSportCell, bundle: nil),
                                     forCellWithReuseIdentifier: Identifier.manualUploadSportCell)
        
        // Change title if needed, not sure which screen comes where.
        self.navigationItem.title = StringConstants.viewTitles.Workout.rawValue
        
        setUIStyling()
        setupGridView()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUIStyling() {
        Styling.removeTabbarItemsText(tabbarItems: (tabBarController?.tabBar.items)!)
        viewDescription.text = StringConstants.chooseSport
    }
    
    func setupGridView() {
        let flow = collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        flow.minimumInteritemSpacing = CGFloat(self.cellMarginSize)
        flow.minimumLineSpacing = CGFloat(self.cellMarginSize)
    }
}

extension ChooseUploadSportViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Data.manualUploadSports.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier.manualUploadSportCell, for: indexPath) as! ManualUploadSportCell
        cell.setData(sportDescription: Data.manualUploadSports[(indexPath.row % Data.manualUploadSports.count)] , sportImage: Data.manualUploadSportsIcons[(indexPath.row % Data.manualUploadSportsIcons.count)])
        cell.roundViewCorners()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        chosenSport = Data.manualUploadSports[(indexPath.row % Data.manualUploadSports.count )]
        chosenSportIcon = Data.manualUploadSportsIcons[(indexPath.row % Data.manualUploadSportsIcons.count)]
        
        performSegue(withIdentifier: SegueConstants.sportChoiceToManualUpload, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == SegueConstants.sportChoiceToManualUpload) {
            if let nextViewController = segue.destination as? ManualUploadController {
                if let sportChoice = chosenSport,
                    let sportImage = chosenSportIcon {
                    nextViewController.sportChoice = sportChoice
                    nextViewController.sportChoiceImage = sportImage
                }
            }
        }
    }
}

extension ChooseUploadSportViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.calculateWith()
        return CGSize(width: width, height: (width + 30.0))
    }
    
    func calculateWith() -> CGFloat {
        let estimatedWidth = CGFloat(self.estimatedWidth)
        let cellCount = floor(CGFloat(self.view.frame.size.width / estimatedWidth))
        
        let margin = CGFloat(cellMarginSize * 2)
        let width = (self.view.frame.size.width - CGFloat(cellMarginSize) * (cellCount - 1) - margin) / cellCount
        
        return width
    }
}
