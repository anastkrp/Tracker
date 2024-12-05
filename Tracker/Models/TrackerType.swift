//
//  TrackerType.swift
//  Tracker
//
//  Created by Anastasiia Ki on 05.12.2024.
//

import Foundation

enum TrackerType {
    case habit, irregularEvent
    
    func navigationTitle() -> String {
        switch self {
        case .habit: return "Новая привычка"
        case .irregularEvent: return "Новое нерегулярное событие"
        }
    }
}
