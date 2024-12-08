//
//  CreateTrackerVC+DataSource.swift
//  Tracker
//
//  Created by Anastasiia Ki on 07.12.2024.
//

import UIKit

extension CreateTrackerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return typeTracker == .habit ? 2 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: TrackerAdjustCell.reuseIdentifier,
            for: indexPath
        )
        guard let adjustCell = cell as? TrackerAdjustCell else { return UITableViewCell() }
        adjustCell.configCell(for: adjustCell, with: indexPath)
        return adjustCell
    }
}
