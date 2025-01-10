//
//  ScheduleVC+DataSource.swift
//  Tracker
//
//  Created by Anastasiia Ki on 09.12.2024.
//

import UIKit

extension ScheduleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Constants.dayCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: WeekdayCell.reuseIdentifier,
            for: indexPath
        )
        guard let weekdayCell = cell as? WeekdayCell else { return UITableViewCell() }
        weekdayCell.delegate = self
        weekdayCell.configCell(for: weekdayCell, with: indexPath, schedule: selectedSchedule)
        return weekdayCell
    }
}
