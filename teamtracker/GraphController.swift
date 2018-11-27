//
//  GraphController.swift
//  teamtracker
//
//  Created by Robby Michels on 01-06-18.
//  Copyright © 2018 Robby Michels. All rights reserved.
//

import Foundation
import UIKit
import SwiftCharts

class GraphController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var chart: BarsChart!
    // Tag which let us find the subview later to replace it with a new one.
    let tag: Int = 1
    // The amount of steps the graph will have.
    let steps: Double = 10
    // Amount of space leaving at the top.
    let graphOverhead: Double = 10
    let tableViewTitle: String = "Activity: "
    let percentageOfWidth: CGFloat = 0.75
    var frame: CGRect!
    var activityArray = [Activity]()
    
    @IBOutlet weak var containerView: View!
    @IBOutlet weak var eventTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = StringConstants.viewTitles.Statistics.rawValue

        eventTableView.delegate = self
        eventTableView.dataSource = self
       
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshPullDown), for: .valueChanged)
        
        // this is the replacement of implementing: "collectionView.addSubview(refreshControl)"
        self.eventTableView.refreshControl = refreshControl
        
        // Width will be the width of the containerView, and the Height will be 75% of the containerView
        let width = containerView.bounds.width
        let height = containerView.bounds.width * percentageOfWidth
        
        frame = CGRect(x: 0, y: 0, width: width, height: height)
        
        getActivities(refreshControl: refreshControl)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activityArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let activityCell = tableView.dequeueReusableCell(withIdentifier: Identifier.cellIdentifier.activityCell.rawValue, for: indexPath) as! ActivityCell
        
        activityCell.descriptionLbl.text = self.tableViewTitle + activityArray[indexPath.row % activityArray.count].timestamp!
        let activityData = Activity.getActivity(activityArray: activityArray, count: indexPath.row)
        activityCell.activityData = activityData
        
        return activityCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let view = self.view.viewWithTag(self.tag) {
            view.removeFromSuperview()
        }
        
        let cell = tableView.cellForRow(at: indexPath) as! ActivityCell
        let max = (getHighestValueFromActivity(activity: cell.activityData) + self.graphOverhead)

        
        let by = max / self.steps
        let chartConfig = BarsChartConfig(
            valsAxisConfig: ChartAxisConfig(from: 0, to: max, by: by)
        )
        
        chart = BarChart.getBarChart(frame: self.frame, config: chartConfig, sport: cell.activityData.sport!,
                                     description: cell.descriptionLbl.text!, distance:
            cell.activityData.distance!, elevation: cell.activityData.elevation!,
                                         tss: cell.activityData.tss!, duration: cell.activityData.duration!)
        
        chart.view.tag = self.tag
        containerView.addSubview(chart.view)
    }
    
    func getActivities(refreshControl: UIRefreshControl) {
        refreshControl.beginRefreshing()
        activityArray.removeAll()
        ActivityHandler.getActivities() { (result) in
            switch result {
                case .Error(_) :
                    DispatchQueue.main.async {
                        return
                    }
                case .Success(let activityArray):
                    DispatchQueue.main.async {
                        self.activityArray = activityArray
                        self.eventTableView.reloadData()
                        refreshControl.endRefreshing()
                        return
                }
            }
        }
    }
    
    func getHighestValueFromActivity(activity: Activity) -> Double {
        var max = 0.0
        if(activity.distance! > max) {
            max = activity.distance!
        }
        if(activity.duration! > max) {
            max = activity.duration!
        }
        if(activity.elevation! > max) {
            max = activity.elevation!
        }
        if(activity.tss! > max) {
            max = activity.tss!
        }
        return max
    }

    @objc func refreshPullDown(refreshControl: UIRefreshControl) {
        getActivities(refreshControl: refreshControl)
    }
}
