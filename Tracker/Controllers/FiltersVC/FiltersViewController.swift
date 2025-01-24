//
//  FiltersViewController.swift
//  Tracker
//
//  Created by Anastasiia Ki on 20.01.2025.
//

import UIKit

final class FiltersViewController: UIViewController {
    
    // MARK: - UI Elements
    private lazy var filtersTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(FiltersCell.self, forCellReuseIdentifier: FiltersCell.reuseIdentifier)
        tableView.backgroundColor = .clear
        tableView.separatorInset = ContentInset.paddingLeftRight()
        tableView.contentInset = ContentInset.paddingTop()
        tableView.isScrollEnabled = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    // MARK: - Properties
    
    let viewModel = FiltersViewModel()
    var filters: [String] = []
    var selectedFilter: FilterType = .all
    
    var closeHandler: (() -> Void)?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bind()
        viewModel.getFilters()
        viewModel.getSelectedFilter()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let navigationController = self.navigationController {
            if navigationController.isBeingDismissed {
                closeHandler?()
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func setupUI(){
        view.backgroundColor = .trackerWhite
        navigationItem.title = "Фильтры"
        view.addSubview(filtersTableView)
        
        NSLayoutConstraint.activate([
            filtersTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            filtersTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            filtersTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            filtersTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func bind() {
        viewModel.onFiltersChanged = { [weak self] filters in
            guard let self else { return }
            self.filters = filters
            self.filtersTableView.reloadData()
        }
        
        viewModel.onSelectedFilterChanged = { [weak self] selectedFilter in
            guard let self else { return }
            self.selectedFilter = selectedFilter
            self.filtersTableView.reloadData()
        }
    }
}
