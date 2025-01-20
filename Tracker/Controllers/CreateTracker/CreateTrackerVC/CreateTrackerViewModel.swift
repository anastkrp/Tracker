//
//  CreateTrackerViewModel.swift
//  Tracker
//
//  Created by Anastasiia Ki on 02.01.2025.
//

import Foundation
import UIKit

final class CreateTrackerViewModel {
    
    private let trackerStore = TrackerStore()
    private let storage = TrackersStorage.shared
    
    private var category: String?
    private var schedule: [Schedule]?
    private var emoji: String = ""
    private var color: UIColor = .clear
    
    var onCategoryChange: Binding<String?>?
    var onScheduleChange: Binding<[Schedule]?>?
    var onEmojiChange: Binding<String>?
    var onColorChange: Binding<UIColor>?
    
    func getSelectedCategory() {
        category = storage.selectedCategory
        onCategoryChange?(category)
    }
    
    func getSelectedSchedule() {
        schedule = storage.selectedSchedule
        onScheduleChange?(schedule)
    }
    
    func saveNewTracker(tracker: Tracker, category: String) {
        trackerStore.saveTrackerWithCategory(tracker: tracker, category: category)
    }
    
    func storageRestData() {
        storage.restData()
    }
    
    // MARK: - Collection View
    
    func numberOfSections() -> Int {
        storage.sectionType.count
    }
    
    func numberOfItems(in section: Int) -> Int {
        storage.sectionType[section].items.count
    }
    
    func getSectionType(at index: IndexPath) -> SectionType {
        storage.sectionType[index.section]
    }
    
    // MARK: -  Edit Tracker Data
    
    func getDataForEdit() {
        guard let data = storage.tracker else { return }
        storage.selectedCategory = data.title
        storage.selectedSchedule = data.trackers.first?.schedule ?? []
        
        getSelectedCategory()
        getSelectedSchedule()
        
        emoji = data.trackers.first?.emoji ?? ""
        onEmojiChange?(emoji)
        
        color = data.trackers.first?.color ?? .clear
        onColorChange?(color)
    }
    
    func indexPathEmoji() -> IndexPath? {
        if let index = storage.sectionType[0].items.firstIndex(where: { $0 as! String == emoji }) {
            return IndexPath(item: index, section: 0)
        } else {
            return nil
        }
    }
    
    func indexPathColor() -> IndexPath? {
        let colorString = color.hexString
        if let index = storage.sectionType[1].items.firstIndex(
            where: { (($0 as! UIColor).hexString).isEqual(colorString) }
        ) {
            return IndexPath(item: index, section: 1)
        } else {
            return nil
        }
    }
    
    func textForTextField() -> String {
        guard let data = storage.tracker else { return ""}
        return data.trackers.first!.name
    }
    
    func getUUID() -> UUID {
        guard let data = storage.tracker else { return UUID() }
        return data.trackers.first!.id
    }
    
    func updateTracker(category: String, tracker: Tracker) {
        trackerStore.updateTracker(category: category, tracker: tracker)
    }
}
