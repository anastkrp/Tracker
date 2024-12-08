//
//  CreateTrackerVC+CellDelegate.swift
//  Tracker
//
//  Created by Anastasiia Ki on 07.12.2024.
//

import UIKit

extension CreateTrackerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
}
