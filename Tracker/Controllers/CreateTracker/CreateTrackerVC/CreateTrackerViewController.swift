//
//  CreateTrackerViewController.swift
//  Tracker
//
//  Created by Anastasiia Ki on 05.12.2024.
//

import UIKit

final class CreateTrackerViewController: UIViewController {
    
    // MARK: - UI Elements
    
    private lazy var trackerTitleTextField: TrackerTextField = {
        let textField = TrackerTextField()
        textField.placeholder = "Введите название трекера"
        textField.delegate = self
        return textField
    }()
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.text = "Ограничение 38 символов"
        label.textColor = .trackerRed
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var textFieldStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [trackerTitleTextField, errorLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var trackerAdjustTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(
            TrackerAdjustCell.self,
            forCellReuseIdentifier: TrackerAdjustCell.reuseIdentifier
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
    
    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.register(
            EmojiCell.self,
            forCellWithReuseIdentifier: EmojiCell.reuseIdentifier
        )
        collection.register(
            ColorCell.self,
            forCellWithReuseIdentifier: ColorCell.reuseIdentifier
        )
        collection.register(
            CreateTrackerSectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: CreateTrackerSectionHeaderView.reuseIdentifier
        )
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.contentInset = UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 18)
        collection.isScrollEnabled = false
        collection.allowsMultipleSelection = true
        collection.dataSource = self
        collection.delegate = self
        return collection
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
        button.setTitle("Отменить", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.setTitleColor(.trackerRed, for: .normal)
        button.backgroundColor = .clear
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.trackerRed.cgColor
        button.layer.cornerRadius = 16
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var createTrackerButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(didTapCreateButton), for: .touchUpInside)
        button.setTitle("Создать", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.setTitleColor(.trackerWhite, for: .normal)
        button.backgroundColor = .trackerBlack
        button.layer.cornerRadius = 16
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [closeButton, createTrackerButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        return scrollView
    }()
    
    
    // MARK: - Properties
    
    var typeTracker: TrackerType = .habit
    private let trackerStore = TrackerStore()
    let storage = TrackersStorage.shared
    var category = ""
    var schedule: [Schedule] = []
    var emojiSelected: String = ""
    var colorSelected: UIColor = .clear
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        stateCreateButton()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        schedule = storage.selectedSchedule
        category = storage.selectedCategory ?? ""
        trackerAdjustTableView.reloadData()
        stateCreateButton()
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        view.backgroundColor = .trackerWhite
        navigationItem.hidesBackButton = true
        navigationItem.title = typeTracker.navigationTitle()
        errorLabel.isHidden = true
        view.addSubview(scrollView)
        contentView.addSubview(textFieldStackView)
        contentView.addSubview(trackerAdjustTableView)
        contentView.addSubview(collectionView)
        contentView.addSubview(buttonsStackView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.heightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            textFieldStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            textFieldStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            textFieldStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            trackerTitleTextField.heightAnchor.constraint(equalToConstant: 75),
            
            trackerAdjustTableView.topAnchor.constraint(equalTo: textFieldStackView.bottomAnchor, constant: 24),
            trackerAdjustTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            trackerAdjustTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            trackerAdjustTableView.heightAnchor.constraint(equalToConstant: typeTracker == .habit ? 150 : 75),
            
            collectionView.topAnchor.constraint(equalTo: trackerAdjustTableView.bottomAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            collectionView.heightAnchor.constraint(equalToConstant: 460),
            
            buttonsStackView.topAnchor.constraint(greaterThanOrEqualTo: collectionView.bottomAnchor, constant: 24),
            buttonsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            buttonsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            buttonsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            buttonsStackView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func setupEnabledCreateButton(_ enabled: Bool) {
        createTrackerButton.isEnabled = enabled
        createTrackerButton.backgroundColor = enabled ? .trackerBlack : .trackerGray
    }
    
    // MARK: - Public Methods
    
    func stateCreateButton() {
        switch typeTracker {
        case .habit:
            if trackerTitleTextField.text?.isEmpty == true || category.isEmpty || schedule.isEmpty || emojiSelected.isEmpty || colorSelected == .clear {
                setupEnabledCreateButton(false)
            } else {
                setupEnabledCreateButton(true)
            }
        case .irregularEvent:
            if trackerTitleTextField.text?.isEmpty == true || category.isEmpty || emojiSelected.isEmpty || colorSelected == .clear {
                setupEnabledCreateButton(false)
            } else {
                setupEnabledCreateButton(true)
            }
        }
    }
    
    // MARK: - Actions
    
    @objc
    private func didTapCloseButton() {
        storage.restData()
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func didTapCreateButton() {
        let newTracker = Tracker(
            id: UUID(),
            name: trackerTitleTextField.text ?? "",
            color: colorSelected,
            emoji: emojiSelected,
            schedule: schedule
        )
        trackerStore.saveTrackerWithCategory(tracker: newTracker, category: category)
        storage.restData()
        dismiss(animated: true)
    }
}

// MARK: - TextField Delegate

extension CreateTrackerViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        
        guard let stringRange = Range(range, in: currentText) else {
            return false
        }
        
        let newText = currentText.replacingCharacters(in: stringRange, with: string)
        
        if newText.count <= 38 {
            errorLabel.isHidden = true
            return true
        } else {
            errorLabel.isHidden = false
            return false
        }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        stateCreateButton()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
