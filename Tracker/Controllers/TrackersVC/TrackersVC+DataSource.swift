//
//  TrackersVC+DataSource.swift
//  Tracker
//
//  Created by Anastasiia Ki on 27.11.2024.
//

import UIKit

extension TrackersViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if categories.isEmpty {
            collectionView.emptyData()
            return 0
        }
        
        if visibleCategories.isEmpty {
            collectionView.searchEmpty()
            return 0
        }
        collectionView.backgroundView = nil
        return visibleCategories.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        visibleCategories[section].trackers.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TrackerCollectionViewCell.reuseIdentifier,
                for: indexPath
            ) as? TrackerCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        let tracker = visibleCategories[indexPath.section].trackers[indexPath.row]
        cell.delegate = self
        cell.configCell(
            for: cell,
            tracker: tracker,
            count: countCompletedTrackers(tracker),
            isCompleted: isCompletedTracker(tracker),
            isPinned: isPinnedTracker(tracker)
        )
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        guard
            let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: SectionHeaderView.reuseIdentifier,
                for: indexPath
            ) as? SectionHeaderView
        else {
            return UICollectionReusableView()
        }
        headerView.titleLabel.text = visibleCategories[indexPath.section].title
        return headerView
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int)
    -> CGSize {
        return CGSize(width: collectionView.frame.width, height: Constants.collectionTrackersVCHeaderHeight)
    }
}
