//
//  StatisticsViewModel.swift
//  Tracker
//
//  Created by Anastasiia Ki on 22.01.2025.
//

import Foundation

final class StatisticsViewModel {
    private let storage = TrackersStorage.shared
    private let trackerStore = TrackerStore()
    private let recordStore = TrackerRecordStore()
    
    private var statistics: [TrackerStatistics] = []
    private var records: [TrackerRecord] = []
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter
    }()
    
    var onStatisticsUpdated: Binding<[TrackerStatistics]>?
    
    func loadStatistics() {
        records = recordStore.getRecords()
        recordsAnalysis()
        statistics = storage.statistics
        onStatisticsUpdated?(statistics)
    }
    
    func isRecordEmpty() -> Bool {
        return records.isEmpty
    }
    
    func recordsAnalysis() {
        var bestPeriod = 0
        var perfectDays = 0
        var dayCount = 1
        
        guard !records.isEmpty else {
            storage.statistics[0].value = bestPeriod
            storage.statistics[1].value = perfectDays
            storage.statistics[2].value = 0
            storage.statistics[3].value = 0
            return
        }
        
        // completedTrackers
        storage.statistics[2].value = records.count
        
        // averageValue
        let uniqueDays = Set(records.map { Calendar.current.startOfDay(for: $0.date) })
        storage.statistics[3].value = records.count / uniqueDays.count
        
        // bestPeriod
        let sortUniqueDays = Array(uniqueDays).sorted()
        for i in 1..<sortUniqueDays.count {
            if Calendar.current.date(
                byAdding: .day,
                value: 1,
                to: sortUniqueDays[i - 1]
            ) == sortUniqueDays[i] {
                dayCount += 1
                bestPeriod = max(bestPeriod, dayCount)
            } else {
                dayCount = 1
            }
        }
        storage.statistics[0].value = bestPeriod

        // perfectDays
        let allTrackers = trackerStore.getTrackers()
        
        for day in uniqueDays {
            let allCompletedDay = records.filter { Calendar.current.startOfDay(for: $0.date) == day }
            let scheduledDay = allTrackers.filter { tracker in
                let weekday = dateFormatter.string(from: day).capitalized
                return tracker.schedule.contains(
                    where: {  $0.weekdayFullName == weekday }
                )
            }
            
            let completedDay = allCompletedDay.filter { tracker in
                scheduledDay.contains(where: { $0.id == tracker.trackerId })
            }
            
            if completedDay.count == scheduledDay.count && scheduledDay.count > 0 {
                perfectDays += 1
            }
        }
        storage.statistics[1].value = perfectDays
    }
}
