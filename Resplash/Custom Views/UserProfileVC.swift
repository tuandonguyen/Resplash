//
//  TestVC2.swift
//  Resplash
//
//  Created by Tuan Nguyen on 7/27/20.
//  Copyright © 2020 Tuan Nguyen. All rights reserved.
//

import UIKit



class UserProfileVC: UIViewController, UICollectionViewDelegateFlowLayout {
    
    var userPhotoItems: [PhotoInfo] = []
    var username = ""
    var page = 1
    var hasMorePhotos = true
    
    var collectionView: UICollectionView!
    enum Section { case main }
    var dataSource: UICollectionViewDiffableDataSource<Section, PhotoInfo>!
    
    let headerView = UIView()
    let bioView = UILabel()
    var buttonViews: [UIView] = []

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
        configureViewController()
        configureCollectionView()
        configureCVDataSource()
        getUserPhotoInfo(for: username, page: page)
        getUserProfile(for: username)
        layoutUI()
    }
    
    //Nav bar shows up during swipe transition.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Shows navigation bar. We have moved from the Search VC to  another VC. Having the back button shown allows us to go back to the Search VC.
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func configureViewController() {
        //Large title moved to the left of the screen.
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        //add a button to add follower to fav list.
        //        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        //        navigationItem.rightBarButtonItem = addButton
    }
    
    //MARK: - Collection View and Collection View Data Source
    
    func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        //        collectionView.contentInset = UIEdgeInsets(top: 4, left: 12, bottom: 4, right: 12)
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.reuseID)
        collectionView.delegate = self
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 400)
        ])
    }
    
    //cell size delegate method
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width * 0.75, height: 400)
    }
    
    //Diffable Data Source for our collectionview.
    func configureCVDataSource() {
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
    
    func updateCV(with photoInfos: [PhotoInfo]) {
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
    
    //MARK: - Network Calls
    func getUserPhotoInfo(for username: String, page: Int) {
        NetworkManager.shared.getUserPhotos(for: username, page: 1) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let userPhotos):
                //store downloaded user photo info into our empty array.
                self.updateCV(with: userPhotos)
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
    
    func getUserProfile(for username: String) {
        NetworkManager.shared.getPublicProfile(for: username, page: page) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let userInfo):
                DispatchQueue.main.async {
                    self.configureProfileElements(with: userInfo)
                }
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
    
    //MARK: - User Profile UI Elements
    //We are adding multiple childVCs to specific containerViews.
    func add(childVC: UIViewController, to containerView: UIView) {
        //select childVC
        addChild(childVC)
        //add selected childVC to the containerView.
        containerView.addSubview(childVC.view)
        //want our childvc to fill up containerview.
        childVC.view.frame = containerView.bounds
        //
        childVC.didMove(toParent: self)
    }
    
    func configureProfileElements(with user: User) {
        self.add(childVC: UserProfileHeaderVC(user: user, delegate: self), to: self.headerView)
    }
    
    func layoutUI() {
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
    }
    
}

//MARK: - Collection View Delegate Methods
extension UserProfileVC: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        return
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        return
    }
    
    
}

//MARK: - User Profile Delegate Methods

extension UserProfileVC: UserProfileHeaderVCDelegate {
    func didTapPortfolioLink(for user: User) {
        guard let url = URL(string: user.portfolioUrl!) else {
            print("portfolio link empty")
            return
        }
        
        //load up a safari vc browser.
        presentSafariVC(with: url)
    }
}
