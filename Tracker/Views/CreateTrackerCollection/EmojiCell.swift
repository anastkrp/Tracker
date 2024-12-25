//
//  CreateTrackerCollectionViewCell.swift
//  Tracker
//
//  Created by Anastasiia Ki on 16.12.2024.
//

import UIKit

final class EmojiCell: UICollectionViewCell {
    static let reuseIdentifier = "emojiCell"
    
    private lazy var emojiLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                backgroundColor = .trackerLightGray
                layer.cornerRadius = 16
            } else {
                backgroundColor = .clear
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        emojiLabel.text = nil
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        contentView.addSubview(emojiLabel)
        NSLayoutConstraint.activate([
            emojiLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            emojiLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
    
    func cellConfig(for cell: EmojiCell, emoji: String) {
        cell.emojiLabel.text = emoji
    }
}
