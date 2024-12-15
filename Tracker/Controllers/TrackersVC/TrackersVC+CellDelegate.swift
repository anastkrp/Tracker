//
//  TrackersVC+CellDelegate.swift
//  Tracker
//
//  Created by Anastasiia Ki on 04.12.2024.
//

import UIKit

extension TrackersViewController: TrackerCollectionCellDelegate {
    func trackerCollectionCellDidTapDone(_ cell: TrackerCollectionViewCell) {
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        let tracker = categories[indexPath.section].trackers[indexPath.row]
        
        if isCompletedTracker(tracker) {
            if let index = completedTrackers.firstIndex(
                where: { $0.trackerId == tracker.id &&
                    Calendar.current.isDate($0.date, inSameDayAs: currentDate) }
            ) {
                completedTrackers.remove(at: index)
                cell.configButton(false)
                cell.countDays.text = countCompletedTrackers(tracker)
            }
        } else {
            if currentDate > Date() { return }
            let record = TrackerRecord(trackerId: tracker.id, date: currentDate)
            completedTrackers.append(record)
            cell.configButton(true)
            cell.countDays.text = countCompletedTrackers(tracker)
        }
    }
}
