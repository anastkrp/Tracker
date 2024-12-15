//
//  TrackerCollectionViewCellDelegate.swift
//  Tracker
//
//  Created by Anastasiia Ki on 04.12.2024.
//

import Foundation

protocol TrackerCollectionCellDelegate: AnyObject {
    func trackerCollectionCellDidTapDone(_ cell: TrackerCollectionViewCell)
}
