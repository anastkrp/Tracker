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
        tableView.separatorInset = ContentInset.paddingLeftRight()
        tableView.contentInset = ContentInset.paddingTop()
        tableView.isScrollEnabled = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    private lazy var doneButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(didTapDoneButton), for: .touchUpInside)
        button.setTitle(
            NSLocalizedString("button.done", comment: ""),
            for: .normal
        )
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.setTitleColor(.trackerWhite, for: .normal)
        button.backgroundColor = .trackerBlack
        button.layer.cornerRadius = 16
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(weekdayTableView)
        view.addSubview(doneButton)
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.addSubview(contentView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    // MARK: - Properties
    
    var selectedSchedule: [Schedule] = []
    private let storage = TrackersStorage.shared
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        selectedSchedule = storage.selectedSchedule
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        view.backgroundColor = .trackerWhite
        navigationItem.hidesBackButton = true
        navigationItem.title = NSLocalizedString("adjustLabel.schedule", comment: "")
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.heightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            weekdayTableView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.topAnchor),
            weekdayTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            weekdayTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            weekdayTableView.heightAnchor.constraint(equalToConstant: CGFloat(Constants.dayCount) * Constants.tableCellHeight),
            
            doneButton.topAnchor.constraint(greaterThanOrEqualTo: weekdayTableView.bottomAnchor, constant: Constants.topAnchor),
            doneButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Constants.bottomAnchor),
            doneButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.leadingButton),
            doneButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.trailingButton),
            doneButton.heightAnchor.constraint(equalToConstant: Constants.heightButton)
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
        storage.selectedSchedule = selectedSchedule
        self.navigationController?.popViewController(animated: true)
    }
}
