//
//  FiltersVC+CellDelegate.swift
//  Tracker
//
//  Created by Anastasiia Ki on 20.01.2025.
//

import UIKit

extension FiltersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constants.tableCellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedFilter = FilterType.allCases[indexPath.row]
        viewModel.updateSelectedFilter(indexPath.row)
        tableView.reloadData()
    }
}
