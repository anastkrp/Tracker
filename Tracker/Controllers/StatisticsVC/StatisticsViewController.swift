//
//  StatisticsViewController.swift
//  Tracker
//
//  Created by Anastasiia Ki on 21.11.2024.
//

import UIKit

final class StatisticsViewController: UIViewController {
    
    // MARK: - UI Elements
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(StatisticsCell.self, forCellReuseIdentifier: StatisticsCell.reuseIdentifier)
        tableView.backgroundColor = .trackerWhite
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isScrollEnabled = false
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    // MARK: - Properties
    
    let viewModel = StatisticsViewModel()
    var statistics: [TrackerStatistics] = []
    var isDataEmpty: Bool = false
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupUI()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadStatistics()
        isDataEmpty = viewModel.isRecordEmpty()
        tableView.reloadData()
    }
    
    // MARK: - Private Methods
    
    private func setupNavigationBar() {
        let titleLabel = NSLocalizedString("statisticsVC.title", comment: "")
        navigationItem.title = titleLabel
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupUI(){
        view.backgroundColor = .trackerWhite
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 77),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func bind() {
        viewModel.onStatisticsUpdated = { [weak self] statistics in
            self?.statistics = statistics
        }
    }
}
