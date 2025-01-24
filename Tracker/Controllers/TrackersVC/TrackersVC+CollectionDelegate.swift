//
//  TrackersVC+CollectionDelegate.swift
//  Tracker
//
//  Created by Anastasiia Ki on 19.01.2025.
//

import UIKit

extension TrackersViewController: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        contextMenuConfigurationForItemAt indexPath: IndexPath,
        point: CGPoint)
    -> UIContextMenuConfiguration? {
        let tracker = categories[indexPath.section].trackers[indexPath.row]
        let isPinned = isPinnedTracker(tracker)
        let typeTracker = tracker.schedule.isEmpty
        
        let pinAction = UIAction(
            title: isPinned ?
            NSLocalizedString("menu.unpin", comment: "") : NSLocalizedString("menu.pin", comment: "")
        ) { [weak self] _ in
            guard let self else { return }
            
            if isPinned {
                self.viewModel.deletePinnedTracker(trackerId: tracker.id)
            } else {
                self.viewModel.savePinnedTracker(trackerId: tracker.id)
            }
        }
        
        let editAction = UIAction(
            title: NSLocalizedString("action.edit", comment: "")
        ) { [weak self] _ in
            guard let self else { return }
            analyticsService.report(event: "click", params: ["Main" : "edit"])
            
            let viewController = CreateTrackerViewController()
            viewController.typeTracker = typeTracker ? .editIrregularEvent : .editHabit
            viewModel.editTrackerData(
                tracker: TrackerCategory(
                    title: categories[indexPath.section].title,
                    trackers: [tracker]
                )
            )
            let navigationController = UINavigationController(rootViewController: viewController)
            self.present(navigationController, animated: true)
        }
        
        let deleteAction = UIAction(
            title: NSLocalizedString("action.delete", comment: ""),
            attributes: .destructive
        ) { [weak self] _ in
            guard let self else { return }
            analyticsService.report(event: "click", params: ["Main" : "delete"])
            
            self.showAlert { resultAction in
                if resultAction {
                    self.viewModel.deleteTracker(trackerId: tracker.id)
                }
            }
        }
        
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            UIMenu(children: [pinAction, editAction, deleteAction])
        }
    }
}
