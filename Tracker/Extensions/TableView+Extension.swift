//
//  TableView+Extension.swift
//  Tracker
//
//  Created by Anastasiia Ki on 11.12.2024.
//

import UIKit

extension UITableView {
    func emptyData() {
        tableBackground(image: "empty", text: "categoryEmpty.title")
    }
    
    func statisticsEmpty() {
        tableBackground(image: "statisticsEmpty", text: "statisticsEmpty.title")
    }
    
    private func tableBackground(image: String, text: String) {
        let imageView = UIImageView(image: UIImage(named: image))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let label = UILabel()
        label.text = NSLocalizedString(text, comment: "")
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
