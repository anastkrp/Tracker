//
//  TrackersStorage.swift
//  Tracker
//
//  Created by Anastasiia Ki on 12.12.2024.
//

import UIKit

final class TrackersStorage {
    static let shared = TrackersStorage()
    
    private init() {}
    
    var trackers: [TrackerCategory] = []
    
    var categories: [String] = []
    var selectedCategory: String?
    var selectedSchedule: [Schedule] = []
    
    let sectionType: [SectionType] = [
        SectionType(title: "Emoji",
                    items: ["🙂", "😻", "🌺", "🐶", "❤️", "😱", "😇", "😡", "🥶", "🤔", "🙌", "🍔", "🥦", "🏓", "🥇", "🎸", "🏝", "😪"]),
        SectionType(title: "Цвет",
                    items: [UIColor.selection1, UIColor.selection2, UIColor.selection3, UIColor.selection4, UIColor.selection5, UIColor.selection6, UIColor.selection7, UIColor.selection8, UIColor.selection9, UIColor.selection10, UIColor.selection11, UIColor.selection12, UIColor.selection13, UIColor.selection14, UIColor.selection15, UIColor.selection16, UIColor.selection17, UIColor.selection18]),
    ]
    
    func restData() {
        selectedCategory = nil
        selectedSchedule = []
        categories = []
    }
}
