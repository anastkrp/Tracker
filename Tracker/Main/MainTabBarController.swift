//
//  MainTabBarController.swift
//  Tracker
//
//  Created by Anastasiia Ki on 21.11.2024.
//

import UIKit

final class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.backgroundColor = .trackerWhite
        createTabBarItem()
    }
    
    private func createTabBarItem() {
        let trackersTabBarItem = TrackersViewController()
        trackersTabBarItem.tabBarItem = UITabBarItem(
            title: "Трекеры",
            image: UIImage(named: "trackers.svg"),
            selectedImage: nil
        )
        
        let statisticsTabBarItem = StatisticsViewController()
        statisticsTabBarItem.tabBarItem = UITabBarItem(
            title: "Статистика",
            image: UIImage(named: "stats.svg"),
            selectedImage: nil
        )
        self.viewControllers = [trackersTabBarItem, statisticsTabBarItem]
    }
}
