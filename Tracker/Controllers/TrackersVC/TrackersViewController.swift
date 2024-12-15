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
    
    lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.register(
            TrackerCollectionViewCell.self,
            forCellWithReuseIdentifier: TrackerCollectionViewCell.reuseIdentifier
        )
        collection.register(
            SectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SectionHeaderView.reuseIdentifier
        )
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collection.dataSource = self
        collection.delegate = self
        return collection
    }()
    
    private lazy var filtersButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .trackerBlue
        button.setTitle("Фильтры", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .regular)
        button.layer.cornerRadius = 16
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Properties
    
    var currentDate = Date()
    
    private let storage = TrackersStorage.shared
    var categories: [TrackerCategory] = []
    var completedTrackers: [TrackerRecord] = []
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        formatter.locale = Locale(identifier: "ru_RU")
        return formatter
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupCollectionView()
        filterDayTrackers()
        NotificationCenter.default.addObserver(self, selector: #selector(updateTrackers), name: Notification.Name("didCreateTracker"), object: nil)
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
    
    private func setupCollectionView() {
        view.addSubview(UIView(frame: .zero))
        view.addSubview(collectionView)
        view.addSubview(filtersButton)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            filtersButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            filtersButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            filtersButton.heightAnchor.constraint(equalToConstant: 48),
            filtersButton.widthAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    private func filterDayTrackers() {
        var filteredTrackers: [TrackerCategory] = []
        let storage = storage.trackers
        let weekday = dateFormatter.string(from: currentDate).capitalized
        
        for category in storage {
            let filtered = category.trackers.filter { tracker in
                if tracker.schedule.isEmpty {
                    // irregularEvent
                    return !completedTrackers.contains { record in
                        record.trackerId == tracker.id &&
                        !Calendar.current.isDate(record.date, inSameDayAs: currentDate)
                    }
                } else {
                    // habit
                    return tracker.schedule.contains(
                        where: { $0.weekdayFullName == weekday }
                    )
                }
            }
            if !filtered.isEmpty {
                filteredTrackers.append(TrackerCategory(title: category.title, trackers: filtered))
            }
        }
        categories = filteredTrackers
    }
    
    // MARK: - Public Methods
    
    func countCompletedTrackers(_ tracker: Tracker) -> String {
        guard !tracker.schedule.isEmpty else { return "" }

        let count = completedTrackers.filter({ $0.trackerId == tracker.id }).count
        return String(count).correctDay()
    }
    
    func isCompletedTracker(_ tracker: Tracker) -> Bool {
        return completedTrackers.contains(
            where: { $0.trackerId == tracker.id &&
                Calendar.current.isDate($0.date, inSameDayAs: currentDate) }
        )
    }
    
    // MARK: - Actions
    
    @objc
    private func didTapAddTrackerButton() {
        let controller = UINavigationController(rootViewController: SelectTypeTrackerVC())
        present(controller, animated: true)
    }
    
    @objc
    private func didTapDatePicker(_ sender: UIDatePicker) {
        let selectedDate = sender.date
        currentDate = selectedDate
        filterDayTrackers()
        collectionView.reloadData()
    }
    
    @objc
    private func updateTrackers() {
        filterDayTrackers()
        collectionView.reloadData()
    }
}
