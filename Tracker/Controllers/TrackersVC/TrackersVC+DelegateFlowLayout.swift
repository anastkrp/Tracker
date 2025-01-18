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
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let category = categories[indexPath.section]
        let tracker = category.trackers[indexPath.item]
        
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            let pinAction = UIAction(
                title: NSLocalizedString("menu.pin", comment: "")
            ) { _ in
                print("pin \(tracker)")
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
