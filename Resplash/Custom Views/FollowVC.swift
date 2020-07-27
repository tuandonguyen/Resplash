//
//  FollowVC.swift
//  Resplash
//
//  Created by Tuan Nguyen on 7/24/20.
//  Copyright © 2020 Tuan Nguyen. All rights reserved.
//

import UIKit

//User's Followers and Following List
//Searcheable Collection View
class FollowVC: UIViewController {
    
    enum Section {
        case main
    }
    
    var containerView: UIView!
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, User>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        configureCollectionView()
        //        configureSearchController()
        //        configureViewController()
        //        getFollowers(username: username, page: page)
        //        configureDataSource()
    }
    
    //Nav bar shows up during swipe transition.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        //Shows navigation bar. We have moved from the Search VC to  another VC. Having the back button shown allows us to go back to the Search VC.
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    //nav bar stuff is configured here too
    func configureViewController() {
        //Large title moved to the left of the screen.
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        //add a button to add follower to fav list.
//        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
//        navigationItem.rightBarButtonItem = addButton
    }
    
    
}
