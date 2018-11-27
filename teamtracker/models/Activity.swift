//
//  Activity.swift
//  teamtracker
//
//  Created by Robby Michels on 01-06-18.
//  Copyright © 2018 Robby Michels. All rights reserved.
//

import Foundation
import UIKit

class Activity {
    let sport: String?
    let distance: Double?
    let elevation: Double?
    let tss: Double?
    let duration: Double?
    let timestamp: String?
    
    init(sport: String, distance: Int64, elevation: Int64, tss: Int64, duration: Double, timestamp: String) {
        self.sport = sport
        
        self.distance = Double(distance)
        
        self.elevation = Double(elevation)
        self.tss = Double(tss)
        self.duration = duration
        self.timestamp = timestamp
    }
    
    init(sport: String, distance: NSNumber, elevation: NSNumber, tss: NSNumber, duration: Double, timestamp: String) {
        self.sport = sport
        self.distance = distance.doubleValue
        self.elevation = elevation.doubleValue
        self.tss = tss.doubleValue
        self.duration = duration
        self.timestamp = timestamp
    }
    
    init(sport: String?, distance: Double?, elevation: Double?, tss: Double?, duration: Double?, timestamp: String?) {
        self.sport = sport
        self.distance = distance
        self.elevation = elevation
        self.tss = tss
        self.duration = duration
        self.timestamp = timestamp
    }
    
    static func getActivity(activityArray: [Activity], count: Int) -> Activity {
        return Activity(sport: activityArray[count % activityArray.count].sport, distance: activityArray[count % activityArray.count].distance , elevation: activityArray[count % activityArray.count].elevation, tss: activityArray[count % activityArray.count].tss, duration: activityArray[count % activityArray.count].duration, timestamp: activityArray[count % activityArray.count].timestamp)
    }
}
