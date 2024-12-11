//
//  ScheduleViewController.swift
//  Tracker
//
//  Created by Anastasiia Ki on 08.12.2024.
//

import UIKit

final class ScheduleViewController: UIViewController {
    
    // MARK: - UI Elements
    
    lazy var weekdayTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(
            WeekdayCell.self,
            forCellReuseIdentifier: WeekdayCell.reuseIdentifier
        )
        tableView.backgroundColor = .clear
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        tableView.contentInset = UIEdgeInsets(top: -36, left: 0, bottom: 0, right: 0)
        tableView.isScrollEnabled = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    private lazy var doneButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(didTapDoneButton), for: .touchUpInside)
        button.setTitle("Готово", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.setTitleColor(.trackerWhite, for: .normal)
        button.backgroundColor = .trackerBlack
        button.layer.cornerRadius = 16
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.addSubview(weekdayTableView)
        scrollView.addSubview(doneButton)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    // MARK: - Properties
    
    var selectedSchedule: [Schedule] = []
    var onSelectSchedule: (([Schedule]) -> Void)?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        view.backgroundColor = .trackerWhite
        navigationItem.hidesBackButton = true
        navigationItem.title = "Расписание"
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            weekdayTableView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 16),
            weekdayTableView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            weekdayTableView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            weekdayTableView.heightAnchor.constraint(equalToConstant: 525),
            weekdayTableView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            
            doneButton.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 20),
            doneButton.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: -20),
            doneButton.topAnchor.constraint(greaterThanOrEqualTo: weekdayTableView.bottomAnchor, constant: 24),
            doneButton.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -16),
            doneButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    // MARK: - Actions
    
    @objc
    private func didTapDoneButton() {
        selectedSchedule.sort { first, second in
            guard
                let left = Schedule.allCases.firstIndex(of: first),
                let right = Schedule.allCases.firstIndex(of: second)
            else { return false }
            return left < right
        }
        onSelectSchedule?(selectedSchedule)
        self.navigationController?.popViewController(animated: true)
    }
}
