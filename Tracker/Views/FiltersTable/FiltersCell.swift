//
//  FiltersCell.swift
//  Tracker
//
//  Created by Anastasiia Ki on 20.01.2025.
//

import UIKit

final class FiltersCell: UITableViewCell {
    static let reuseIdentifier = "FiltersCell"
    
    override func prepareForReuse() {
        super.prepareForReuse()
        textLabel?.text = nil
        accessoryType = .none
    }
    
    func configCell(for cell: FiltersCell, with indexPath: IndexPath, filters: [String], selectedFilter: String) {
        cell.textLabel?.text = filters[indexPath.row]
        cell.accessoryType = filters[indexPath.row] == selectedFilter ? .checkmark : .none
        cell.backgroundColor = .trackerBackground
        cell.selectionStyle = .none
    }
}
