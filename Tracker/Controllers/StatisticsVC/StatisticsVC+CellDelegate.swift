//
//  StatisticsVC+CellDelegate.swift
//  Tracker
//
//  Created by Anastasiia Ki on 22.01.2025.
//

import UIKit

extension StatisticsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constants.tableStatisticsCellHeight
    }
}
