//
//  TrackerType.swift
//  Tracker
//
//  Created by Anastasiia Ki on 05.12.2024.
//

import Foundation

enum TrackerType {
    case habit, irregularEvent, editHabit, editIrregularEvent
    
    func navigationTitle() -> String {
        switch self {
        case .habit: return NSLocalizedString("trackerType.habit", comment: "")
        case .irregularEvent: return NSLocalizedString("trackerType.irregularEvent", comment: "")
        case .editHabit: return NSLocalizedString("trackerType.editHabit", comment: "")
        case .editIrregularEvent: return NSLocalizedString("trackerType.editIrregularEvent", comment: "")
        }
    }
}
