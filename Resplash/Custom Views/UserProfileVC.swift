//
//  TestVC2.swift
//  Resplash
//
//  Created by Tuan Nguyen on 7/27/20.
//  Copyright © 2020 Tuan Nguyen. All rights reserved.
//

import UIKit

class UserProfileVC: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    //Create main section of our collection view.
    enum Section { case main }
    
    var userPhotoItems: [PhotoInfo] = []
    var username = "scottwebb"
    var page = 1
    var hasMorePhotos = true
    
    var collectionView: UICollectionView!
    //data source needs to know about our section and our items.
    //Declaring our data source.
    var dataSource: UICollectionViewDiffableDataSource<Section, PhotoInfo>!
    
    //custom initializer to take in username
    init(username: String) {
        super.init(nibName: nil, bundle: nil)
        self.username = username
        title = username
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureViewController()
        getUserPhotoInfo(for: username, page: page)
        configureDataSource()
    }
    
    //Set up our Collection View
    func configureCollectionView() {
        //view.bounds fills up the entire view, no matter what device you're on.
        //initialize the object. Then use it.
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.contentInset = UIEdgeInsets(top: 4, left: 12, bottom: 4, right: 12)
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 400)
        ])
        //register our custom cell Photo Cell.
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.reuseID)
        collectionView.delegate = self

    }
    
    //cell size delegate method
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width * 0.75, height: 400)
    }
    
//    extension YourViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: screenWidth, height: screenWidth)
//    }
    
    //nav bar stuff is configured here too
    func configureViewController() {
        //Large title moved to the left of the screen.
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        //add a button to add follower to fav list.
//        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
//        navigationItem.rightBarButtonItem = addButton
    }
    
    func getUserPhotoInfo(for username: String, page: Int) {
            NetworkManager.shared.getUserPhotos(for: username, page: 1) { [weak self] (result) in
                guard let self = self else { return }
                switch result {
                case .success(let userPhotos):
                    //store downloaded user photo info into our empty array.
                    self.updateUI(with: userPhotos)
                case .failure(let error):
                    print(error.rawValue)
                }
            }
        }

    //Diffable Data Source for our collectionview.
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, PhotoInfo>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, photoInfo) -> UICollectionViewCell? in
            
            //The cell here is a default cell. We need to cast this as a follower cell.
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.reuseID, for: indexPath) as! PhotoCell
            cell.clipsToBounds = true
            //for every follower, we sent that user name to the set function which sets the text label of the cell to the username!
            //configure each cell that comes on screen.
            cell.set(photoInfo: photoInfo)
            //return the cell to use it.
            return cell
        })
    }
    
    func updateUI(with photoInfos: [PhotoInfo]) {
        if photoInfos.count < 30 {
            self.hasMorePhotos = false
        }
        self.userPhotoItems.append(contentsOf: photoInfos)
        self.updateData(on: self.userPhotoItems)
    }

    func updateData(on photoInfo: [PhotoInfo]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, PhotoInfo>()
        snapshot.appendSections([.main])
        snapshot.appendItems(photoInfo)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }

}
