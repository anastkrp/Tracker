//
//  StatisticsVC+DataSource.swift
//  Tracker
//
//  Created by Anastasiia Ki on 22.01.2025.
//

import UIKit

extension StatisticsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isDataEmpty {
            tableView.statisticsEmpty()
            return 0
        }
        return statistics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: StatisticsCell.reuseIdentifier,
            for: indexPath
        )
        guard let statisticsCell = cell as? StatisticsCell else { return UITableViewCell() }
        statisticsCell.configCell(for: statisticsCell, with: indexPath, statistics: statistics)
        return statisticsCell
    }
}
