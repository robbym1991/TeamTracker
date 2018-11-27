//
//  BarChart.swift
//  teamtracker
//
//  Created by Robby Michels on 06-06-18.
//  Copyright © 2018 Robby Michels. All rights reserved.
//

import Foundation
import SwiftCharts

struct BarChart {
    static func getBarChart(frame: CGRect, config: BarsChartConfig, sport: String, description: String, distance: Double, elevation: Double, tss: Double, duration: Double) -> BarsChart {
        return BarsChart(
            frame: frame,
            chartConfig: config,
            xTitle: description,
            yTitle: sport,
            bars: [
                (StringConstants.graphTitles.distance.rawValue, distance),
                (StringConstants.graphTitles.elevation.rawValue, elevation),
                (StringConstants.graphTitles.tss.rawValue, tss),
                (StringConstants.graphTitles.duration.rawValue, duration)
            ],
            color: Colors.lightTurquoise,
            barWidth: Styling.graphBarWidth
        )
    }
}

