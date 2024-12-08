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
    
    private lazy var trackerAdjustTableView: UITableView = {
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
        button.addTarget(self, action: #selector(createButton), for: .touchUpInside)
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
    
    // MARK: - Properties
    
    var typeTracker: TrackerType = .habit
    var category = ""
    var schedule = [String]()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        stateCreateButton()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        view.backgroundColor = .trackerWhite
        navigationItem.hidesBackButton = true
        navigationItem.title = typeTracker.navigationTitle()
        view.addSubview(textFieldStackView)
        errorLabel.isHidden = true
        view.addSubview(trackerAdjustTableView)
        view.addSubview(buttonsStackView)
        NSLayoutConstraint.activate([
            textFieldStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            textFieldStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textFieldStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            trackerTitleTextField.heightAnchor.constraint(equalToConstant: 75),
            
            trackerAdjustTableView.topAnchor.constraint(equalTo: textFieldStackView.bottomAnchor, constant: 24),
            trackerAdjustTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            trackerAdjustTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            trackerAdjustTableView.heightAnchor.constraint(equalToConstant: typeTracker == .habit ? 150 : 75),
            
            buttonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            buttonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            buttonsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            buttonsStackView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func stateCreateButton() {
        switch typeTracker {
        case .habit:
            if trackerTitleTextField.text?.isEmpty == true || category.isEmpty || schedule.isEmpty {
                setupEnabledCreateButton(false)
            } else {
                setupEnabledCreateButton(true)
            }
        case .irregularEvent:
            if trackerTitleTextField.text?.isEmpty == true || category.isEmpty {
                setupEnabledCreateButton(false)
            } else {
                setupEnabledCreateButton(true)
            }
        }
    }
    
    private func setupEnabledCreateButton(_ enabled: Bool) {
        createTrackerButton.isEnabled = enabled
        createTrackerButton.backgroundColor = enabled ? .trackerBlack : .trackerGray
    }
    
    // MARK: - Actions
    
    @objc
    private func didTapCloseButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func createButton() {
        print("create tracker")
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
}
