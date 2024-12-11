//
//  ScheduleVC+CellDelegate.swift
//  Tracker
//
//  Created by Anastasiia Ki on 09.12.2024.
//

import UIKit

extension ScheduleViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
}

extension ScheduleViewController: WeekdayCellDelegate {
    func didSelectWeekday(_ cell: WeekdayCell) {
        guard let indexPath = weekdayTableView.indexPath(for: cell) else { return }
        selectedSchedule.append(Schedule.allCases[indexPath.row])
    }
    
    func didDeselectWeekday(_ cell: WeekdayCell) {
        guard let indexPath = weekdayTableView.indexPath(for: cell) else { return }
        let day = Schedule.allCases[indexPath.row]
        selectedSchedule.removeAll(where: { $0 == day })
    }
}
