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
        button.setTitle("Привычка", for: .normal)
        button.backgroundColor = .trackerBlack
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.layer.cornerRadius = 16
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var irregularEventButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(didTapIrregularEventButton), for: .touchUpInside)
        button.setTitle("Нерегулярные событие", for: .normal)
        button.backgroundColor = .trackerBlack
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.layer.cornerRadius = 16
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [habitButton, irregularEventButton])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
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
        navigationItem.title = "Создание трекера"
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            habitButton.heightAnchor.constraint(equalToConstant: 60),
            irregularEventButton.heightAnchor.constraint(equalToConstant: 60)
            ])
    }
    
    // MARK: - Actions
    
    @objc
    private func didTapHabitButton() {
        let v = CreateTrackerViewController()
        v.typeTracker = .habit
        let navitationController = UINavigationController(rootViewController: v)
        present(navitationController, animated: true)
    }
    
    @objc
    private func didTapIrregularEventButton() {
        let v = CreateTrackerViewController()
        v.typeTracker = .irregularEvent
        let navitationController = UINavigationController(rootViewController: v)
        present(navitationController, animated: true)
    }
}
