//
//  CreateTrackerViewController.swift
//  Tracker
//
//  Created by Anastasiia Ki on 05.12.2024.
//

import UIKit

final class CreateTrackerViewController: UIViewController {
    
    // MARK: - UI Elements
    
    // MARK: - Properties
    
    var typeTracker: TrackerType = .habit
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .trackerWhite
        navigationItem.title = typeTracker.navigationTitle()
    }
    
    // MARK: - Private Methods
    
    // MARK: - Actions
}
