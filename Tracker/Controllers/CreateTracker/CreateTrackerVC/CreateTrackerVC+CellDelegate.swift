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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let categoryVC = CategoryViewController()
            categoryVC.onDismiss = { [weak self] in
                guard let self else { return }
                self.category = storage.selectedCategory ?? ""
                self.trackerAdjustTableView.reloadData()
                self.stateCreateButton()
            }
            let navigation = UINavigationController(rootViewController: categoryVC)
            navigation.presentationController?.delegate = categoryVC
            present(navigation, animated: true)
        } else {
            let scheduleVC = ScheduleViewController()
            navigationController?.pushViewController(scheduleVC, animated: true)
        }
    }
}
