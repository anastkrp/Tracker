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
        return typeTracker == .habit || typeTracker == .editHabit ? 2 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: TrackerAdjustCell.reuseIdentifier,
            for: indexPath
        )
        guard let adjustCell = cell as? TrackerAdjustCell else { return UITableViewCell() }
        let subtitle = NSLocalizedString("adjustLabel.schedule.subtitle", comment: "")
        let weekdayString = schedule.count == 7 ? subtitle : schedule.map { $0.weekdayShortName }.joined(separator: ", ")
        adjustCell.configCell(for: adjustCell, with: indexPath, detailText: [category, weekdayString])
        return adjustCell
    }
}

// MARK: - Collection View

extension CreateTrackerViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.numberOfSections()
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        viewModel.numberOfItems(in: section)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let section = viewModel.getSectionType(at: indexPath)
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
            
            var emojiView = String()
            
            if let emoji = item as? String {
                emojiView = emoji
            } else {
                emojiView = ""
            }
            
            emojiCell.cellConfig(for: emojiCell, emoji: emojiView)
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
            
            var colorView = UIColor()
            
            if let color = item as? UIColor {
                colorView = color
            } else {
                colorView = .clear
            }
            
            colorCell.cellConfig(for: colorCell, color: colorView)
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
        headerView.titleLabel.text = viewModel.getSectionType(at: indexPath).title
        return headerView
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int)
    -> CGSize {
        return CGSize(width: collectionView.frame.width, height: Constants.collectionCreateVCHeaderHeight)
    }
}
