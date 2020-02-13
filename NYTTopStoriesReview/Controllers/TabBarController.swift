//
//  TabBarController.swift
//  NYTTopStoriesReview
//
//  Created by Oscar Victoria Gonzalez  on 2/6/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit
import DataPersistence

class TabBarController: UITabBarController {
    
    // Step 1: In order for your data persistance to work your model must conform to equatable
    private var dataPersistance = DataPersistence<Article>(filename: "savedArticles.plist")
    
    private lazy var neewsFeedVC: NewsFeedController = {
        let viewController = NewsFeedController(dataPersistance)
        viewController.tabBarItem = UITabBarItem(title: "News Feed", image: UIImage(systemName: "eyeglasses"), tag: 0)
        return viewController
    }()
    
    
    private lazy var savedArticlesVC: SavedArticlesController = {
        let viewController = SavedArticlesController(dataPersistance)
        viewController.tabBarItem = UITabBarItem(title: "Saved", image: UIImage(systemName: "folder"), tag: 0)
        // Step 3: We inject
        // setting up data persistance and its delegate
        return viewController
    }()
    
    
    private lazy var settingsVC: SettingsViewController = {
        let viewController = SettingsViewController()
        viewController.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 0)
        return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        
        viewControllers = [UINavigationController(rootViewController: neewsFeedVC),
                           UINavigationController(rootViewController: savedArticlesVC),
                           UINavigationController(rootViewController: settingsVC)]
    }
    
}
