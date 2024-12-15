//
//  CategoryVC+CellDelegate.swift
//  Tracker
//
//  Created by Anastasiia Ki on 11.12.2024.
//

import UIKit

extension CategoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        75
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCategory = categories[indexPath.row]
        storage.selectedCategory = selectedCategory
        tableView.reloadData()
    }
}
