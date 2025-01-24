//
//  CollectionView+Extension.swift
//  Tracker
//
//  Created by Anastasiia Ki on 12.12.2024.
//

import UIKit

extension UICollectionView {
    func emptyData() {
        collectionBackground(image: "empty", text: "emptyState.title")
    }
    
    func searchEmpty() {
        collectionBackground(image: "searchEmpty", text: "searchEmpty.title")
    }
    
    private func collectionBackground(image: String, text: String){
        let imageView = UIImageView(image: UIImage(named: image))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let emptyStateText = NSLocalizedString(text, comment: "Text displayed on empty state")
        
        let label = UILabel()
        label.text = emptyStateText
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .trackerBlack
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        view.addSubview(imageView)
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -60),
            imageView.heightAnchor.constraint(equalToConstant: 80),
            imageView.widthAnchor.constraint(equalToConstant: 80),
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        self.backgroundView = view
    }
}
