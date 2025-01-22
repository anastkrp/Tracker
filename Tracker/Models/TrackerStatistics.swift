//
//  TrackerStatistics.swift
//  Tracker
//
//  Created by Anastasiia Ki on 22.01.2025.
//

import Foundation

struct TrackerStatistics {
    var value: Int
    let statisticsType: StatisticsType
}

enum StatisticsType: CaseIterable {
    case bestPeriod, perfectDays, completedTrackers, averageValue
    
    var statisticTitle: String {
        switch self {
        case .bestPeriod:
            return NSLocalizedString("statistic.bestPeriod", comment: "")
        case .perfectDays:
            return NSLocalizedString("statistic.perfectDays", comment: "")
        case .completedTrackers:
            return NSLocalizedString("statistic.completedTrackers", comment: "")
        case .averageValue:
            return NSLocalizedString("statistic.averageValue", comment: "")
        }
    }
}
