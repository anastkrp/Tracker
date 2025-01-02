//
//  PageViewController.swift
//  Tracker
//
//  Created by Anastasiia Ki on 02.01.2025.
//

import UIKit

final class PageViewController: UIViewController {
    
    // MARK: - UI Elements
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var pageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 3
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .trackerBlackWithoutDarkMode
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
        button.setTitle("Вот это технологии!", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.setTitleColor(.trackerWhiteWithoutDarkMode, for: .normal)
        button.backgroundColor = .trackerBlackWithoutDarkMode
        button.layer.cornerRadius = 16
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Properties
    
    private let storage = OnboardingStorage.shared
    var imageName: String = ""
    var pageLabelText: String = ""
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        backgroundImageView.image = UIImage(named: imageName)
        pageLabel.text = pageLabelText
        view.addSubview(backgroundImageView)
        view.addSubview(pageLabel)
        view.addSubview(closeButton)
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            pageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingAnchor),
            pageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.trailingAnchor),
            pageLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: Constants.pageLabelCenterY),
            
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingButton),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.trailingButton),
            closeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Constants.bottomButton),
            closeButton.heightAnchor.constraint(equalToConstant: Constants.heightButton)
        ])
    }
    
    // MARK: - Actions
    
    @objc
    private func didTapCloseButton() {
        guard let window = UIApplication.shared.windows.first else {
            assertionFailure("Invalid window configuration")
            return
        }
        let tabBarController = MainTabBarController()
        window.rootViewController = tabBarController
        
        storage.hideOnboardingVC = true
        
        UIView.transition(
            with: window,
            duration: 0.3,
            options: .transitionCrossDissolve,
            animations: nil,
            completion: nil
        )
    }
}
