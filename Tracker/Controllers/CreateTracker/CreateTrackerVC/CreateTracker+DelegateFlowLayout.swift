//
//  CreateTracker+DelegateFlowLayout.swift
//  Tracker
//
//  Created by Anastasiia Ki on 16.12.2024.
//

import UIKit

extension CreateTrackerViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let size = (collectionView.bounds.width - 90) / 6
        return CGSize(width: size, height: size)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 5
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
        shouldSelectItemAt indexPath: IndexPath
    ) -> Bool {
        collectionView.indexPathsForSelectedItems?.filter({
            $0.section == indexPath.section
        }).forEach({
            collectionView.deselectItem(at: $0, animated: false)
        })
        return true
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        let section = storage.sectionType[indexPath.section]
        let item = section.items[indexPath.item]
        
        if indexPath.section == 0 {
            emojiSelected = item as! String
        } else {
            colorSelected = item as! UIColor
        }
        stateCreateButton()
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        shouldDeselectItemAt indexPath: IndexPath
    ) -> Bool {
        if indexPath.section == 0 {
            emojiSelected = ""
        } else {
            colorSelected = UIColor.clear
        }
        stateCreateButton()
        return true
    }
}
