//
//  TabBarController.swift
//  NYTTopStoriesReview
//
//  Created by Oscar Victoria Gonzalez  on 2/6/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    private lazy var neewsFeedVC: NewsFeedController = {
        let viewController = NewsFeedController()
        viewController.tabBarItem = UITabBarItem(title: "News Feed", image: UIImage(systemName: "eyeglasses"), tag: 0)
        return viewController
    }()
    
    private lazy var savedArticlesVC: SavedArticlesController = {
           let viewController = SavedArticlesController()
           viewController.tabBarItem = UITabBarItem(title: "Saved", image: UIImage(systemName: "folder"), tag: 0)
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
        
        viewControllers = [neewsFeedVC, savedArticlesVC, settingsVC]
        
        
    }
    


}
