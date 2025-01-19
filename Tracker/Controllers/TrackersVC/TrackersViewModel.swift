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
    private let pinnedStore = TrackerPinnedStore()
    
    private var categories: [TrackerCategory] = []
    private var completedTrackers: [TrackerRecord] = []
    private var pinnedTrackers: [TrackerPinned] = []
    
    var onCategoriesChange: Binding<[TrackerCategory]>?
    var onCompletedTrackersChange: Binding<[TrackerRecord]>?
    var onPinnedTrackersChange: Binding<[TrackerPinned]>?
    
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
        categories = addPinnedCategory(filteredTrackers)
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
    
    func addPinnedCategory(_ filteredTrackers: [TrackerCategory]) -> [TrackerCategory] {
        let pinnedTrackersId = pinnedStore.getPinnedTrackers().map {$0.trackerId}
        var pinnedTrackers: [Tracker] = []
        var trackers: [TrackerCategory] = []
        
        for category in filteredTrackers {
            pinnedTrackers.append(
                contentsOf: category.trackers.filter { pinnedTrackersId.contains($0.id) }
            )
        }
        
        if pinnedTrackers.isEmpty {
            trackers = filteredTrackers.sorted { $0.title < $1.title }
        } else {
            let withoutPinned = filteredTrackers.map { category in
                let filteredTrackers = category.trackers.filter { !pinnedTrackersId.contains($0.id) }
                return TrackerCategory(title: category.title, trackers: filteredTrackers)
            }.filter { !$0.trackers.isEmpty }
            
            let pinnedCategory = TrackerCategory(title: "Закрепленные", trackers: pinnedTrackers)
            
            trackers = withoutPinned.sorted { $0.title < $1.title }
            trackers.insert(pinnedCategory, at: 0)
        }
        return trackers
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
    
    // MARK: - Pinned Trackers
    
    func getPinnedTrackers() {
        pinnedTrackers = pinnedStore.getPinnedTrackers()
        onPinnedTrackersChange?(pinnedTrackers)
    }
    
    func savePinnedTracker(trackerId: UUID) {
        pinnedStore.savePinnedTracker(trackerId: trackerId)
    }
    
    func deletePinnedTracker(trackerId: UUID) {
        pinnedStore.deletePinnedTracker(trackerId: trackerId)
    }
}
