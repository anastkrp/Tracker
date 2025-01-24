//
//  Schedule.swift
//  Tracker
//
//  Created by Anastasiia Ki on 27.11.2024.
//

import Foundation

enum Schedule: CaseIterable, Codable {
    case monday, tuesday, wednesday, thursday, friday, saturday, sunday
    
    var weekdayFullName: String {
        switch self {
        case .monday: 
            return NSLocalizedString("weekdayFullName.monday", comment: "")
        case .tuesday:
            return NSLocalizedString("weekdayFullName.tuesday", comment: "")
        case .wednesday:
            return NSLocalizedString("weekdayFullName.wednesday", comment: "")
        case .thursday:
            return NSLocalizedString("weekdayFullName.thursday", comment: "")
        case .friday:
            return NSLocalizedString("weekdayFullName.friday", comment: "")
        case .saturday:
            return NSLocalizedString("weekdayFullName.saturday", comment: "")
        case .sunday:
            return NSLocalizedString("weekdayFullName.sunday", comment: "")
        }
    }
    
    var weekdayShortName: String {
        switch self {
        case .monday:
            return NSLocalizedString("weekdayShortName.monday", comment: "")
        case .tuesday:
            return NSLocalizedString("weekdayShortName.tuesday", comment: "")
        case .wednesday:
            return NSLocalizedString("weekdayShortName.wednesday", comment: "")
        case .thursday:
            return NSLocalizedString("weekdayShortName.thursday", comment: "")
        case .friday:
            return NSLocalizedString("weekdayShortName.friday", comment: "")
        case .saturday:
            return NSLocalizedString("weekdayShortName.saturday", comment: "")
        case .sunday:
            return NSLocalizedString("weekdayShortName.sunday", comment: "")
        }
    }
}
