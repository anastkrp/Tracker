//
//  CreateTrackerVC+DataSource.swift
//  Tracker
//
//  Created by Anastasiia Ki on 07.12.2024.
//

import UIKit

// MARK: - Table View

extension CreateTrackerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return typeTracker == .habit ? 2 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: TrackerAdjustCell.reuseIdentifier,
            for: indexPath
        )
        guard let adjustCell = cell as? TrackerAdjustCell else { return UITableViewCell() }
        let weekdayString = schedule.count == 7 ? "Каждый день" : schedule.map { $0.weekdayShortName }.joined(separator: ", ")
        adjustCell.configCell(for: adjustCell, with: indexPath, detailText: [category, weekdayString])
        return adjustCell
    }
}

// MARK: - Collection View

extension CreateTrackerViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        storage.sectionType.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        storage.sectionType[section].items.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let section = storage.sectionType[indexPath.section]
        let item = section.items[indexPath.item]
        
        if indexPath.section == 0 {
            guard
                let emojiCell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: EmojiCell.reuseIdentifier,
                    for: indexPath
                ) as? EmojiCell
            else {
                return UICollectionViewCell()
            }
            emojiCell.emojiLabel.text = item as? String
            return emojiCell
            
        } else {
            guard
                let colorCell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: ColorCell.reuseIdentifier,
                    for: indexPath
                ) as? ColorCell
            else {
                return UICollectionViewCell()
            }
            colorCell.colorView.backgroundColor = item as? UIColor
            return colorCell
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        guard
            let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: CreateTrackerSectionHeaderView.reuseIdentifier,
                for: indexPath
            ) as? CreateTrackerSectionHeaderView
        else {
            return UICollectionReusableView()
        }
        headerView.titleLabel.text = storage.sectionType[indexPath.section].title
        return headerView
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int)
    -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 74)
    }
}
