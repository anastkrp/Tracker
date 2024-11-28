//
//  TrackerCollectionViewCell.swift
//  Tracker
//
//  Created by Anastasiia Ki on 28.11.2024.
//

import UIKit

final class TrackerCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "TrackerCell"
    
    lazy var cardView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var emojiLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 12, y: 12, width: 24, height: 24))
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .center
        label.backgroundColor  = .trackerWhiteTransparent
        label.layer.cornerRadius = 12
        label.clipsToBounds = true
        return label
    }()
    
    lazy var name: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .trackerWhiteWithoutDarkMode
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var countDays: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .trackerBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var doneButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Plus.svg"), for: .normal)
        button.tintColor = .trackerWhite
        button.layer.cornerRadius = 17
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    private func setupCell() {
        addSubview(cardView)
        cardView.addSubview(emojiLabel)
        cardView.addSubview(name)
        addSubview(countDays)
        addSubview(doneButton)
        
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: topAnchor),
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cardView.heightAnchor.constraint(equalToConstant: 90),

            name.topAnchor.constraint(equalTo: emojiLabel.bottomAnchor, constant: 8),
            name.heightAnchor.constraint(equalToConstant: 43),
            name.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            name.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            
            countDays.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 8),
            countDays.centerYAnchor.constraint(equalTo: doneButton.centerYAnchor),
            countDays.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            countDays.trailingAnchor.constraint(equalTo: doneButton.leadingAnchor, constant: -8),
            
            doneButton.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 8),
            doneButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            doneButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            doneButton.heightAnchor.constraint(equalToConstant: 34),
            doneButton.widthAnchor.constraint(equalToConstant: 34)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    func configCell(for cell: TrackerCollectionViewCell, tracker: Tracker) {
        cell.cardView.backgroundColor = tracker.color
        cell.emojiLabel.text = tracker.emoji
        cell.name.text = tracker.name
        cell.countDays.text = "1 день"
        cell.doneButton.backgroundColor = tracker.color
    }
    
    @objc
    private func doneButtonTapped() {
       
    }
}
