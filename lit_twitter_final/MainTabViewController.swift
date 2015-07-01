//
//  MainTabViewController.swift
//  lit_twitter
//
//  Created by keita kutsuno on 2015/06/27.
//  Copyright (c) 2015年 keita kutsuno. All rights reserved.
//

import Foundation
import UIKit

class MainTabViewController: UITabBarController {
    
    var timelineView: TimelineViewController!
    var favoriteView: FavoriteViewController!
    var reloadButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timelineView = TimelineViewController()
        favoriteView = FavoriteViewController()
    
        timelineView.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.Recents, tag: 1)
        favoriteView.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.Favorites, tag: 2)
    
        
        var timelineViewController = UINavigationController(rootViewController: timelineView)
        var favoriteViewController = UINavigationController(rootViewController: favoriteView)
        
        self.setViewControllers([timelineViewController,favoriteViewController,], animated: false)
        
    }
}