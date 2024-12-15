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
    
    func restData() {
        selectedCategory = nil
        selectedSchedule = []
        categories = []
    }
}
