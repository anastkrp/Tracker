//
//  FilterType.swift
//  Tracker
//
//  Created by Anastasiia Ki on 20.01.2025.
//

import Foundation

enum FilterType: CaseIterable {
    case all, today, completed, uncompleted
    
    func nameFilter() -> String {
        switch self {
        case .all: return NSLocalizedString("nameFilter.all", comment: "")
        case .today: return NSLocalizedString("nameFilter.today", comment: "")
        case .completed: return NSLocalizedString("nameFilter.completed", comment: "")
        case .uncompleted: return NSLocalizedString("nameFilter.uncompleted", comment: "")
        }
    }
}
