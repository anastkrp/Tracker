//
//  CreateTrackerViewModel.swift
//  Tracker
//
//  Created by Anastasiia Ki on 02.01.2025.
//

import Foundation

final class CreateTrackerViewModel {
    
    private let trackerStore = TrackerStore()
    private let storage = TrackersStorage.shared
    
    private var category: String?
    private var schedule: [Schedule]?
    
    var onCategoryChange: Binding<String?>?
    var onScheduleChange: Binding<[Schedule]?>?
    
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
}
