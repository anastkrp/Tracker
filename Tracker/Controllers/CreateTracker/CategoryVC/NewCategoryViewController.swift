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
    
    private let viewModel = CategoryViewModel()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        stateDoneButton()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        view.backgroundColor = .trackerWhite
        navigationItem.hidesBackButton = true
        navigationItem.title = "Новая категория"
        view.addSubview(categoryTitleTextField)
        view.addSubview(doneButton)
        NSLayoutConstraint.activate([
            categoryTitleTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.topAnchor),
            categoryTitleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:  Constants.leadingAnchor),
            categoryTitleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.trailingAnchor),
            categoryTitleTextField.heightAnchor.constraint(equalToConstant: Constants.textFieldHeight),
            
            doneButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: Constants.bottomAnchor),
            doneButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:  Constants.leadingButton),
            doneButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.trailingButton),
            doneButton.heightAnchor.constraint(equalToConstant: Constants.heightButton)
        ])
    }
    
    // MARK: - Actions
    
    @objc
    private func didTapDoneButton() {
        viewModel.addCategory(title: categoryTitleTextField.text ?? "")
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
