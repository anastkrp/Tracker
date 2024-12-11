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
//            let viewController = ScheduleViewController()
//            navigationController?.pushViewController(viewController, animated: true)
        } else {
            let viewController = ScheduleViewController()
            viewController.selectedSchedule = schedule
            viewController.onSelectSchedule = { [weak self] schedule in
                guard let self else { return }
                self.schedule = schedule
                self.trackerAdjustTableView.reloadData()
            }
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
