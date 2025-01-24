//
//  FiltersVC+DataSource.swift
//  Tracker
//
//  Created by Anastasiia Ki on 20.01.2025.
//

import UIKit

extension FiltersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: FiltersCell.reuseIdentifier,
            for: indexPath
        )
        guard let filterCell = cell as? FiltersCell else { return UITableViewCell() }
        filterCell.configCell(for: filterCell,
                              with: indexPath,
                              filters: filters,
                              selectedFilter: selectedFilter.nameFilter()
        )
        return filterCell
    }
}
