//
//  Constants.swift
//  Tracker
//
//  Created by Anastasiia Ki on 27.12.2024.
//

import UIKit

struct Constants {
    // Anchor
    static let topAnchor: CGFloat = 24.0
    static let bottomAnchor: CGFloat = -16.0
    static let leadingAnchor: CGFloat = 16.0
    static let trailingAnchor: CGFloat = -16.0
    
    // Button
    static let leadingButton: CGFloat = 20.0
    static let trailingButton: CGFloat = -20.0
    static let heightButton: CGFloat = 60.0
    static let bottomButton: CGFloat = -50.0
    
    // DatePicker Button
    static let datePickerHeight: CGFloat = 34.0
    static let datePickerWidth: CGFloat = 100.0
    
    // Filters Button
    static let filtersButtonHeight: CGFloat = 48.0
    static let filtersButtonWidth: CGFloat = 120.0
    
    // TextField
    static let textFieldHeight: CGFloat = 75.0
    
    // PageControl
    static let pageControlBottom: CGFloat = -134.0
    
    // PageLabel
    static let pageLabelCenterY: CGFloat = 68.0
    
    // logoImageView
    static let logoImageViewHeight: CGFloat = 94.0
    static let logoImageViewWidth: CGFloat = 91.0
    
    // Table
    static let tableCellHeight: CGFloat = 75.0
    
    static let dayCount: Int = 7
    
    // Collection
    static let collectionViewHeight: CGFloat = 460.0
    static let collectionCreateVCHeaderHeight: CGFloat = 74.0
    static let collectionTrackersVCHeaderHeight: CGFloat = 46.0
    static let collectionCreateVCSpacing: CGFloat = 5.0
    static let collectionTrackersVCSpacing: CGFloat = 9.0
    
    static func collectionCreateVCCellSize(width: CGFloat) -> CGFloat {
        return (width - 90) / 6
    }
    
    static func collectionTrackersVCCellSize(width: CGFloat) -> CGSize {
        return CGSize(width: (width - 41) / 2, height: 148)
    }
}

struct TextFieldRange {
    static let maxLength: Int = 38
}

struct ContentInset {
    static func paddingLeftRight() -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    static func paddingTop() -> UIEdgeInsets {
        UIEdgeInsets(top: -36, left: 0, bottom: 0, right: 0)
    }
    
    static func paddingCollectionCreateVC() -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 18)
    }
    
    static func paddingCollectionTrackersVC() -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 16, bottom: 80, right: 16)
    }
}
