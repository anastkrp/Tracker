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
        datePicker.locale = Locale.current
        datePicker.preferredDatePickerStyle = .compact
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(self.didTapDatePicker), for: .valueChanged)
        let rightBarButtonItem = UIBarButtonItem(customView: datePicker)
        return rightBarButtonItem
    }()
    
    private lazy var searchBar: UISearchController = {
        let search = UISearchController(searchResultsController: nil)
        search.searchBar.placeholder = NSLocalizedString("searchBar.placeholder", comment: "")
        search.obscuresBackgroundDuringPresentation = false
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
        collection.contentInset = ContentInset.paddingLeftRight()
        collection.dataSource = self
        collection.delegate = self
        return collection
    }()
    
    private lazy var filtersButton: UIButton = {
        let buttonTitle = NSLocalizedString("button.filters", comment: "")
        let button = UIButton()
        button.backgroundColor = .trackerBlue
        button.setTitle(buttonTitle, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .regular)
        button.layer.cornerRadius = 16
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Properties
    
    var currentDate = Date()
    
    let viewModel = TrackersViewModel()
    private let trackerStore = TrackerStore()
    private let recordStore = TrackerRecordStore()
    let analyticsService = AnalyticsService()
    
    var categories: [TrackerCategory] = []
    var visibleCategories: [TrackerCategory] = []
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
        
        trackerStore.delegate = self
        recordStore.delegate = self
        searchBar.searchResultsUpdater = self
        
        bind()
        viewModel.getCompletedTrackers()
        filterDayTrackers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        analyticsService.report(event: "open", params: ["Main" : ""])
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        analyticsService.report(event: "close", params: ["Main" : ""])
    }
    
    // MARK: - Private Methods
    
    private func setupNavigationBar() {
        let titleLabel = NSLocalizedString("trackersVC.title", comment: "")
        navigationItem.title = titleLabel
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: addTrackerButton)
        
        datePickerButton.customView?.widthAnchor.constraint(equalToConstant: Constants.datePickerWidth).isActive = true
        datePickerButton.customView?.heightAnchor.constraint(equalToConstant: Constants.datePickerHeight).isActive = true
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
            
            filtersButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: Constants.bottomAnchor),
            filtersButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            filtersButton.heightAnchor.constraint(equalToConstant: Constants.filtersButtonHeight),
            filtersButton.widthAnchor.constraint(equalToConstant: Constants.filtersButtonWidth)
        ])
    }
    
    private func bind() {
        viewModel.onCategoriesChange = { [weak self] categories in
            self?.categories = categories
            self?.visibleCategories = categories
        }
        
        viewModel.onCompletedTrackersChange = { [weak self] trackers in
            self?.completedTrackers = trackers
        }
    }
    
    private func filterDayTrackers() {
        let weekday = dateFormatter.string(from: currentDate).capitalized
        viewModel.getCategoriesWithFilter(weekday: weekday, currentDate: currentDate)
    }
    
    // MARK: - Public Methods
    
    func countCompletedTrackers(_ tracker: Tracker) -> String {
        guard !tracker.schedule.isEmpty else { return "" }
        let count = completedTrackers.filter({ $0.trackerId == tracker.id }).count
        let dayString = String.localizedStringWithFormat(
            NSLocalizedString("countDay", comment: ""),
            count
        )
        return dayString
    }
    
    func isCompletedTracker(_ tracker: Tracker) -> Bool {
        return completedTrackers.contains(
            where: { $0.trackerId == tracker.id &&
                Calendar.current.isDate($0.date, inSameDayAs: currentDate) }
        )
    }
    
    func showAlert(completion: @escaping (Bool) -> Void) {
        let alert = UIAlertController(
            title: "",
            message: NSLocalizedString("alert.message", comment: ""),
            preferredStyle: .actionSheet
        )
        
        let deleteAction = UIAlertAction(
            title: NSLocalizedString("action.delete", comment: ""),
            style: .destructive
        ) { _ in
            completion(true)
        }
        
        let cancelAction = UIAlertAction(
            title: NSLocalizedString("action.cancel", comment: ""),
            style: .cancel
        ) { _ in
            completion(false)
        }
        
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    // MARK: - Actions
    
    @objc
    private func didTapAddTrackerButton() {
        analyticsService.report(event: "click", params: ["Main" : "add_track"])
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
}

// MARK: - Tracker Store Delegate

extension TrackersViewController: TrackerStoreDelegate {
    func trackerStoreDidUpdateTrackers() {
        filterDayTrackers()
        collectionView.reloadData()
    }
}

// MARK: - Record Store Delegate

extension TrackersViewController: TrackerRecordStoreDelegate {
    func trackerRecordStoreDidUpdate() {
        viewModel.getCompletedTrackers()
    }
}

// MARK: - Search Results Updating

extension TrackersViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            visibleCategories = categories.filter { tracker in
                tracker.trackers.contains { $0.name.lowercased().contains(searchText.lowercased()) }
            }
        } else {
            visibleCategories = categories
        }
        collectionView.reloadData()
    }
}
