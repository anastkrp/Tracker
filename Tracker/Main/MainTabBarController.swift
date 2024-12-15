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
        setupTabBar()
        createTabBarItem()
    }
    
    private func createTabBarItem() {
        let trackersTabBarItem = UINavigationController(rootViewController: TrackersViewController())
        trackersTabBarItem.tabBarItem = UITabBarItem(
            title: "Трекеры",
            image: UIImage(named: "trackers.svg"),
            selectedImage: nil
        )
        
        let statisticsTabBarItem = UINavigationController(rootViewController: StatisticsViewController())
        statisticsTabBarItem.tabBarItem = UITabBarItem(
            title: "Статистика",
            image: UIImage(named: "stats.svg"),
            selectedImage: nil
        )
        self.viewControllers = [trackersTabBarItem, statisticsTabBarItem]
    }
    
    private func setupTabBar() {
        let line = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 1))
        line.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        self.tabBar.addSubview(line)
    }
}
