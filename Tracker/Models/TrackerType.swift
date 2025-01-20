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
        case .habit: return "Новая привычка"
        case .irregularEvent: return "Новое нерегулярное событие"
        case .editHabit: return "Редактирование привычки"
        case .editIrregularEvent: return "Редактирование нерегулярного события"
        }
    }
}
