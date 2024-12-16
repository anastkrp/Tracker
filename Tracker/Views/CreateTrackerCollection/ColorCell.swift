//
//  ColorCell.swift
//  Tracker
//
//  Created by Anastasiia Ki on 16.12.2024.
//

import UIKit

final class ColorCell: UICollectionViewCell {
    static let reuseIdentifier = "colorCell"
    
    lazy var colorView: UIView = {
        let view = UIView()
        view.backgroundColor = .selection7
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                layer.borderWidth = 3
                layer.borderColor = colorView.backgroundColor?.withAlphaComponent(0.3).cgColor
                layer.cornerRadius = 8
            } else {
                layer.borderColor = UIColor.clear.cgColor
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        colorView.backgroundColor = UIColor.clear
        layer.borderColor = UIColor.clear.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        contentView.addSubview(colorView)
        
        NSLayoutConstraint.activate([
            colorView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            colorView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            colorView.heightAnchor.constraint(equalToConstant: 40),
            colorView.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
}
