//
//  SelectTypeTrackerVC.swift
//  Tracker
//
//  Created by Anastasiia Ki on 05.12.2024.
//

import UIKit

final class SelectTypeTrackerVC: UIViewController {
    
    // MARK: - UI Elements
    
    private lazy var habitButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(didTapHabitButton), for: .touchUpInside)
        button.setTitle(
            NSLocalizedString("button.habit", comment: ""),
            for: .normal
        )
        button.backgroundColor = .trackerBlack
        button.setTitleColor(.trackerWhite, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.layer.cornerRadius = 16
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var irregularEventButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(didTapIrregularEventButton), for: .touchUpInside)
        button.setTitle(
            NSLocalizedString("button.irregularEvent", comment: ""),
            for: .normal
        )
        button.backgroundColor = .trackerBlack
        button.setTitleColor(.trackerWhite, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.layer.cornerRadius = 16
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [habitButton, irregularEventButton])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        view.backgroundColor = .trackerWhite
        navigationItem.title = NSLocalizedString("selectTypeTrackerVC.title", comment: "")
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.leadingButton),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: Constants.trailingButton),
            habitButton.heightAnchor.constraint(equalToConstant: Constants.heightButton),
            irregularEventButton.heightAnchor.constraint(equalToConstant: Constants.heightButton)
            ])
    }
    
    private func navigation(for typeTracker: TrackerType) {
        let viewController = CreateTrackerViewController()
        viewController.typeTracker = typeTracker
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    // MARK: - Actions
    
    @objc
    private func didTapHabitButton() {
        navigation(for: .habit)
    }
    
    @objc
    private func didTapIrregularEventButton() {
        navigation(for: .irregularEvent)
    }
}
