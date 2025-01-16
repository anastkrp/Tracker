//
//  TrackerTests.swift
//  TrackerTests
//
//  Created by Anastasiia Ki on 16.01.2025.
//

import XCTest
import SnapshotTesting
@testable import Tracker

final class TrackerTests: XCTestCase {
    
    func testViewControllerSnapshot() {
        let window = UIWindow()
        let viewController = MainTabBarController()
        window.rootViewController = viewController
        window.makeKeyAndVisible()
        assertSnapshot(of: viewController, as: .image)
    }
    
    func testViewControllerLightThemeSnapshot() {
        let window = UIWindow()
        let viewController = MainTabBarController()
        window.rootViewController = viewController
        window.makeKeyAndVisible()
        assertSnapshot(of: viewController, as: .image(traits: .init(userInterfaceStyle: .light)))
    }
}
