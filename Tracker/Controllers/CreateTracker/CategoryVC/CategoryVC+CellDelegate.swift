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
        viewModel.didSelectCategory(indexPath: indexPath)
        tableView.reloadData()
    }
}
