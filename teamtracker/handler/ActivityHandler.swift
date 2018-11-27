//
//  ActivityHandler.swift
//  teamtracker
//
//  Created by Robby Michels on 01-06-18.
//  Copyright © 2018 Robby Michels. All rights reserved.
//

import Foundation
import UIKit

struct ActivityHandler {
    static var activityArray = [Activity]()
    
    enum Results<T> {
        case Success(T)
        case Error(String)
    }
    
    static func getActivities(completion: @escaping (Results<[Activity]>) -> Void ) -> Void {
        activityArray.removeAll()
        ActivityProvider.getActivities() { (result) in
            switch result {
                case .Success(let activityNSArray):
                    for activity in activityNSArray {
                        if let activityObject = activity as? [String: Any] {
                            let activityModel = Activity(sport: activityObject["sport"] as! String, distance: activityObject["distance"] as! NSNumber,
                                                         elevation: activityObject["elevation"] as! NSNumber, tss: activityObject["tss"] as! NSNumber,
                                                         duration: self.getDuration(durationHour: activityObject["duration_hr"] as! String,
                                                                                    durationMin: activityObject["duration_min"] as! String),
                                                         timestamp: activityObject["datetime"] as! String)
                            self.activityArray.append(activityModel)
                        }
                    }

                    completion(.Success(activityArray))
                case .Error(let errorMsg):
                    completion(.Error(errorMsg))
            }
        }
    }
    
    static func getDuration(durationHour: String, durationMin: String) -> Double {
        if let durationHr = Double(durationHour),
            let durationMinute = Double(durationMin) {
            return (durationHr * 60) + durationMinute
        }
        
        return 0
    }
}
