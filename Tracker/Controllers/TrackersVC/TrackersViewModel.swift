//
//  TrackersViewModel.swift
//  Tracker
//
//  Created by Anastasiia Ki on 02.01.2025.
//

import Foundation

final class TrackersViewModel {
    private let trackerStore = TrackerStore()
    private let categoryStore = TrackerCategoryStore()
    private let recordStore = TrackerRecordStore()
    
    private var categories: [TrackerCategory] = []
    private var completedTrackers: [TrackerRecord] = []
    
    var onCategoriesChange: Binding<[TrackerCategory]>?
    var onCompletedTrackersChange: Binding<[TrackerRecord]>?
    
    // MARK: - Categories With Trackers
    
    func getCategoriesWithFilter(weekday: String, currentDate: Date) {
        var filteredTrackers: [TrackerCategory] = []
        let storage = groupedTrackers()
        
        for category in storage {
            let filtered = category.trackers.filter { tracker in
                if tracker.schedule.isEmpty {
                    // irregularEvent
                    return !completedTrackers.contains { record in
                        record.trackerId == tracker.id &&
                        !Calendar.current.isDate(record.date, inSameDayAs: currentDate)
                    }
                } else {
                    // habit
                    return tracker.schedule.contains(
                        where: { $0.weekdayFullName == weekday }
                    )
                }
            }
            if !filtered.isEmpty {
                filteredTrackers.append(TrackerCategory(title: category.title, trackers: filtered))
            }
        }
        categories = filteredTrackers.sorted { $0.title < $1.title }
        onCategoriesChange?(categories)
    }
    
    private func groupedTrackers() -> [TrackerCategory] {
        var groupedTrackers: [String: [Tracker]] = [:]
        let allTrackers = trackerStore.getTrackers()
        let allCategories = categoryStore.getCategoriesWithTrackers(trackers: allTrackers)
        
        for tracker in allTrackers {
            if let categoryTitle = allCategories.first(
                where: { $0.trackers.contains(where: { $0.id == tracker.id} ) }
            ) {
                groupedTrackers[categoryTitle.title, default: []].append(tracker)
            }
        }
        return groupedTrackers.map { TrackerCategory(title: $0.key, trackers: $0.value) }
    }
    
    func deleteTracker(trackerId: UUID) {
        trackerStore.deleteTracker(withId: trackerId)
    }
    
    // MARK: - Completed Trackers
    
    func getCompletedTrackers() {
        completedTrackers = recordStore.getRecords()
        onCompletedTrackersChange?(completedTrackers)
    }
    
    func saveCompletedTracker(trackerId: UUID, date: Date) {
        recordStore.saveRecord(trackerId: trackerId, date: date)
    }
    
    func deleteCompletedTracker(trackerId: UUID, date: Date) {
        recordStore.deleteRecord(trackerId: trackerId, date: date)
    }
}
