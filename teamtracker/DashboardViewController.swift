//
//  FirstViewController.swift
//  teamtracker
//
//  Created by Robby Michels on 07-02-18.
//  Copyright © 2018 Robby Michels. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    let viewTitle: String = "Home"
    
    @IBOutlet weak var myTeamTitleLbl: Label!
    @IBOutlet weak var upcommingEventTitleLbl: Label!
    @IBOutlet weak var nextEventDayLbl: Label!
    @IBOutlet weak var nextEventDateLbl: Label!
    @IBOutlet weak var nextEventTimeLbl: Label!
    @IBOutlet weak var nextEventLocationLbl: Label!
    @IBOutlet weak var nextEventDescriptionLbl: UILabel!
    @IBOutlet weak var nextEventLbl: UILabel!
    @IBOutlet weak var upcommingEventsCollectionView: UICollectionView!
    @IBOutlet weak var myTeamCollectionView: UICollectionView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var rightBarItem: UIBarButtonItem!
    @IBOutlet weak var eventTimeLbl: Label!
    @IBOutlet weak var eventLocationLbl: Label!
    
    @IBOutlet weak var largeCardView: UIView!
    @IBOutlet weak var eventInfoView: View!
    
    @IBOutlet weak var teamMateImage: UIImageView!
    @IBOutlet weak var dateView: UIView!
    
    @IBOutlet var contentView: UIView!
    
    //arrays will be replaced with data from api.
    var dayArray = ["Mon", "Tue", "Wen", "Thu", "Fri", "Sat", "Sun"]
    var dateArray = ["01", "14", "30", "11", "04"]
    var eventDescriptionArray = ["Hardlopen", "Wedstrijd", "Cardio"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.title = StringConstants.viewTitles.Home.rawValue
        
        upcommingEventsCollectionView.delegate = self
        myTeamCollectionView.delegate = self
        
        upcommingEventsCollectionView.dataSource = self
        myTeamCollectionView.dataSource = self
        
        upcommingEventsCollectionView.backgroundColor = scrollView.backgroundColor
        myTeamCollectionView.backgroundColor = scrollView.backgroundColor
        
        setUIStyling()
    }
    
    func setUIStyling() {
        Styling.removeTabbarItemsText(tabbarItems: (tabBarController?.tabBar.items)!)
        largeCardView.roundViewCorners()
        Styling.roundViewCorners(view: dateView)
        Styling.viewShadow(view: largeCardView)
        eventInfoView.gradientBackgroundRightRoundCorner(startColor: Colors.lightBlue, endColor: Colors.darkerLightBlue)
        
        teamMateImage.roundCorner()
        eventLocationLbl.iconLeft(image: UIImage(named: StringConstants.placeholderLocationIcon)!, initialString: StringConstants.placeholderEvent)
        eventTimeLbl.iconLeft(image: UIImage(named: StringConstants.placeholderTimeIcon)!, initialString: StringConstants.placeholderTimeEvent)
        setupText()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Random amount of cells to be created, will be changed when API call can be made.
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.upcommingEventsCollectionView {
            let upcommingEventCell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier.upcommingEvent, for: indexPath) as! UpcommingEventCell
            setUpcommingCellStyling(cell: upcommingEventCell)
            upcommingEventCell.day.text = dayArray[indexPath.row % dayArray.count]
            upcommingEventCell.date.text = dateArray[indexPath.row % dateArray.count]
            upcommingEventCell.eventDescription.text = eventDescriptionArray[indexPath.row % eventDescriptionArray.count]
            upcommingEventCell.eventDescriptionView.gradientBackgroundRightRoundCorner(startColor: Colors.lightTurquoise, endColor: Colors.lightGreenish)
            return upcommingEventCell
        }
        
        if collectionView == self.myTeamCollectionView {
            let myTeamCell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier.myTeam, for: indexPath) as! MyTeamCell
            setMyTeamCellStyling(cell: myTeamCell)
            // Hardcoded image will be replaced when api call can be made.
            myTeamCell.playerImage.image = UIImage(named: StringConstants.placeholderImage)
            myTeamCell.playerImage.roundCornerWithBorder()
            myTeamCell.playerName.text = StringConstants.placeHolderText
            
            return myTeamCell
        }
        return UICollectionViewCell()
    }
    
    func setUpcommingCellStyling(cell: UpcommingEventCell) {
        cell.containerView.roundViewCorners()
        cell.clipsToBounds = false
        cell.containerView.viewShadow()
        cell.dayDateView.roundViewCorners()
        cell.eventDescriptionView.roundViewCorners()
        cell.layer.cornerRadius = Styling.cornerRadius
    }
    
    func setMyTeamCellStyling(cell: MyTeamCell) {
        cell.subView.roundViewCorners()
        cell.subView.viewShadow()
        cell.clipsToBounds = false
    }
    
    func setupText() {
        nextEventLbl.text = StringConstants.dashboardView.nextEventTitle.rawValue
        nextEventDayLbl.text = StringConstants.dashboardView.nextEventDay.rawValue
        nextEventDateLbl.text = StringConstants.dashboardView.nextEventDate.rawValue
        nextEventTimeLbl.text = StringConstants.dashboardView.nextEventTime.rawValue
        nextEventLocationLbl.text = StringConstants.dashboardView.nextEventLocation.rawValue
        nextEventDescriptionLbl.text = StringConstants.dashboardView.nextEventDescription.rawValue
        
        upcommingEventTitleLbl.text = StringConstants.dashboardView.upcommingEventTitle.rawValue
        myTeamTitleLbl.text = StringConstants.dashboardView.myTeamTitle.rawValue
    }
}

