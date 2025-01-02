//
//  OnboardingStorage.swift
//  Tracker
//
//  Created by Anastasiia Ki on 02.01.2025.
//

import Foundation

final class OnboardingStorage {
    static let shared = OnboardingStorage()
    
    private init() {}
    
    private enum Keys: String {
        case hideOnboarding
    }
    
    private let storage: UserDefaults = .standard
    
    var hideOnboardingVC: Bool {
        get { storage.bool(forKey: Keys.hideOnboarding.rawValue) }
        set { storage.set(newValue, forKey: Keys.hideOnboarding.rawValue) }
    }
}
