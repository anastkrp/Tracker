//
//  CreateTrackerSectionHeaderView.swift
//  Tracker
//
//  Created by Anastasiia Ki on 16.12.2024.
//

import UIKit

final class CreateTrackerSectionHeaderView: UICollectionReusableView {
    
    static let reuseIdentifier = "createTrackerSectionHeader"
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Section title"
        label.textColor = .trackerBlack
        label.font = .systemFont(ofSize: 19, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 32),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 9),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -9)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
