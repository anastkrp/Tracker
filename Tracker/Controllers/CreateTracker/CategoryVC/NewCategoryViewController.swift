//
//  NewCategoryViewController.swift
//  Tracker
//
//  Created by Anastasiia Ki on 12.12.2024.
//

import UIKit

final class NewCategoryViewController: UIViewController {
    
    // MARK: - UI Elements
    
    private lazy var categoryTitleTextField: TrackerTextField = {
        let textField = TrackerTextField()
        textField.placeholder = "Введите название категории"
        textField.delegate = self
        return textField
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
    
    // MARK: - Properties
    
    let storage = TrackersStorage.shared
    var newCategory: String?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        stateDoneButton()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        view.backgroundColor = .trackerWhite
        navigationItem.hidesBackButton = true
        navigationItem.title = "Новая категория"
        view.addSubview(categoryTitleTextField)
        view.addSubview(doneButton)
        NSLayoutConstraint.activate([
            categoryTitleTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            categoryTitleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:  16),
            categoryTitleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            categoryTitleTextField.heightAnchor.constraint(equalToConstant: 75),
            
            doneButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            doneButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:  20),
            doneButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            doneButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    // MARK: - Actions
    
    @objc
    private func didTapDoneButton() {
        storage.categories.append(categoryTitleTextField.text ?? "")
        self.navigationController?.popViewController(animated: true)
    }
    
    private func stateDoneButton() {
        let enabled = categoryTitleTextField.text?.isEmpty == true
        doneButton.isEnabled = enabled ? false : true
        doneButton.backgroundColor = enabled  ? .trackerGray : .trackerBlack
    }
}

// MARK: - TextField Delegate

extension NewCategoryViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        stateDoneButton()
    }
}
