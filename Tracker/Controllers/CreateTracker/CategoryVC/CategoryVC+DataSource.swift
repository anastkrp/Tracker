//
//  CategoryVC+DataSource.swift
//  Tracker
//
//  Created by Anastasiia Ki on 11.12.2024.
//

import UIKit

extension CategoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if categories.isEmpty {
            tableView.emptyData()
        } else {
            tableView.backgroundView = nil
        }
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: CategoryCell.reuseIdentifier,
            for: indexPath
        )
        guard let categoryCell = cell as? CategoryCell else { return UITableViewCell() }
        categoryCell.configCell(for: categoryCell, with: indexPath, categories: categories, selectedCategory: selectedCategory)
        return categoryCell
    }
}
