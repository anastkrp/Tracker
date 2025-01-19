//
//  TrackersVC+DelegateFlowLayout.swift
//  Tracker
//
//  Created by Anastasiia Ki on 28.11.2024.
//

import UIKit

extension TrackersViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return Constants.collectionTrackersVCCellSize(width: collectionView.bounds.width)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        return Constants.collectionTrackersVCSpacing
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 0
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        contextMenuConfigurationForItemAt indexPath: IndexPath,
        point: CGPoint)
    -> UIContextMenuConfiguration? {
        let tracker = categories[indexPath.section].trackers[indexPath.row]
        let isPinned = isPinnedTracker(tracker)
        
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            let pinAction = UIAction(
                title: isPinned ?
                NSLocalizedString("menu.unpin", comment: "") : NSLocalizedString("menu.pin", comment: "")
            ) { [weak self]_ in
                if isPinned {
                    self?.viewModel.deletePinnedTracker(trackerId: tracker.id)
                } else {
                    self?.viewModel.savePinnedTracker(trackerId: tracker.id)
                }
            }
            
            let editAction = UIAction(
                title: NSLocalizedString("action.edit", comment: "")
            ) { _ in
                print("edit \(tracker)")
            }
            
            let deleteAction = UIAction(
                title: NSLocalizedString("action.delete", comment: ""),
                attributes: .destructive
            ) { [weak self] _ in
                self?.showAlert { resultAction in
                    if resultAction {
                        self?.viewModel.deleteTracker(trackerId: tracker.id)
                    }
                }
            }
            return UIMenu(children: [pinAction, editAction, deleteAction])
        }
    }
}
