//
//  CategoryTableViewCell.swift
//  Tracker
//
//  Created by Anastasiia Ki on 11.12.2024.
//

import UIKit

final class CategoryCell: UITableViewCell {
    static let reuseIdentifier = "CategoryCell"
    
    override func prepareForReuse() {
        super.prepareForReuse()
        textLabel?.text = nil
        accessoryType = .none
    }
    
    func configCell(for cell: CategoryCell, with indexPath: IndexPath, categories: [String], selectedCategory: String) {
        cell.textLabel?.text = categories[indexPath.row]
        cell.accessoryType = categories[indexPath.row] == selectedCategory ? .checkmark : .none
        cell.backgroundColor = .trackerBackground
        cell.selectionStyle = .none
    }
}
