//
//  SplashViewController.swift
//  Tracker
//
//  Created by Anastasiia Ki on 02.01.2025.
//

import UIKit

final class SplashViewController: UIViewController {
    
    // MARK: - UI Elements
    
    private lazy var logoImageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "Logo"))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    // MARK: - Properties
    
    private let storage = OnboardingStorage.shared
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if storage.hideOnboardingVC {
            switchToTabBarController()
        } else {
            switchToOnboardingController()
        }
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        view.backgroundColor = .trackerBlue
        view.addSubview(logoImageView)
        
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: Constants.logoImageViewWidth),
            logoImageView.heightAnchor.constraint(equalToConstant: Constants.logoImageViewHeight)
        ])
    }
    
    private func switchToOnboardingController() {
        guard let window = UIApplication.shared.windows.first else {
            assertionFailure("Invalid window configuration")
            return
        }
        let onboardingController = OnboardingViewController()
        window.rootViewController = onboardingController
    }
    
    private func switchToTabBarController() {
        guard let window = UIApplication.shared.windows.first else {
            assertionFailure("Invalid window configuration")
            return
        }
        let tabBarController = MainTabBarController()
        window.rootViewController = tabBarController
    }
}
