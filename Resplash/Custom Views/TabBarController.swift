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
        UITabBar.appearance().tintColor = .systemBlue
        viewControllers = [SearchNC(), SavedUsersNC()]
    }
    
        func SearchNC() -> UINavigationController {
        let searchVC = SearchVC()
        searchVC.title = "Search"
        //Set the search VC as tab bar item 0.
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        //set the NC root as searchVC.
        return UINavigationController(rootViewController: searchVC)
    }
    
    func SavedUsersNC() -> UINavigationController {
        let userListVC = UserListVC()
        userListVC.title = "Saved Users"
        userListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        return UINavigationController(rootViewController: userListVC)
    }

}
