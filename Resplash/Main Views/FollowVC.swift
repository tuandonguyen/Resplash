//
//  FollowVC.swift
//  Resplash
//
//  Created by Tuan Nguyen on 7/24/20.
//  Copyright © 2020 Tuan Nguyen. All rights reserved.
//

import UIKit

class FollowVC: UIViewController {
    enum Section {
        case main
    }
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, User>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    


}
