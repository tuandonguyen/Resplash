//
//  TabBarController.swift
//  UnsplashLikes
//
//  Created by admin on 7/23/20.
//  Copyright © 2020 Tuan Nguyen. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemBlue
        viewControllers = [SearchNC(), UserNC()]
    }
    
        func SearchNC() -> UINavigationController {
        let searchVC = SearchVC()
        searchVC.title = "Discover"
        //Set the search VC as tab bar item 0.
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        //set the NC root as searchVC.
        return UINavigationController(rootViewController: searchVC)
    }
    
    func UserNC() -> UINavigationController {
        let userVC = UserListVC()
        userVC.title = "User List"
        //Set the Favorites list VC as tab bar item 1.
        userVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        //set the NC root as favoriteslistVC.
        return UINavigationController(rootViewController: userVC)
    }

}
