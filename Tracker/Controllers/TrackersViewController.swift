//
//  TrackersViewController.swift
//  Tracker
//
//  Created by Anastasiia Ki on 21.11.2024.
//

import UIKit

final class TrackersViewController: UIViewController {
    
    // MARK: - UI Elements
    
    private lazy var addTrackerButton: UIButton = {
        let button = UIButton.systemButton(
            with: UIImage(named: "AddButton")!,
            target: self,
            action: #selector(self.didTapAddTrackerButton)
        )
        button.tintColor = .trackerBlack
        return button
    }()
    
    private lazy var datePickerButton: UIBarButtonItem = {
        let datePicker = UIDatePicker()
        datePicker.locale = Locale(identifier: "ru_RU")
        datePicker.preferredDatePickerStyle = .compact
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(self.didTapDatePicker), for: .valueChanged)
        let rightBarButtonItem = UIBarButtonItem(customView: datePicker)
        return rightBarButtonItem
    }()
    
    private lazy var searchBar: UISearchController = {
        let search = UISearchController(searchResultsController: nil)
        search.searchBar.placeholder = "Поиск"
        search.hidesNavigationBarDuringPresentation = false
        return search
    }()
    
    // MARK: - Private Properties
    
    private var categories: [TrackerCategory] = [
        TrackerCategory(
            title: "Домашний уют",
            trackers: [
                Tracker(id: UInt(0),
                        name: "Поливать растения",
                        color: .selection5,
                        emoji: "❤️",
                        schedule: Schedule(monday: true, tuesday: false, wednesday: false, thursday: true, friday: false, saturday: false, sunday: true))
            ]),
        TrackerCategory(
            title: "Радостные мелочи",
            trackers: [
                Tracker(id: UInt(1),
                        name: "Кошка заслонила камеру на созвоне",
                        color: .selection2,
                        emoji: "😻",
                        schedule: Schedule(monday: true, tuesday: true, wednesday: true, thursday: true, friday: true, saturday: true, sunday: true))
            ])
    ]
    
    private var completedTrackers: [TrackerRecord] = [
        TrackerRecord(trackerId: UInt(0), date: Date())
    ]
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    // MARK: - Private Methods
    
    private func setupNavigationBar() {
        navigationItem.title = "Трекеры"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: addTrackerButton)
        
        datePickerButton.customView?.widthAnchor.constraint(equalToConstant: 100).isActive = true
        datePickerButton.customView?.heightAnchor.constraint(equalToConstant: 34).isActive = true
        navigationItem.rightBarButtonItem = datePickerButton
        
        navigationItem.searchController = searchBar
    }
    
    // MARK: - Actions
    
    @objc
    private func didTapAddTrackerButton() {
        
    }
    
    @objc
    private func didTapDatePicker(_ sender: UIDatePicker) {
        let selectedDate = sender.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let formattedDate = dateFormatter.string(from: selectedDate)
        print("Выбранная дата: \(formattedDate)")
    }
}
