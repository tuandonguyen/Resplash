//
//  UserProfileHeaderVC.swift
//  Resplash
//
//  Created by Tuan Nguyen on 7/28/20.
//  Copyright © 2020 Tuan Nguyen. All rights reserved.
//

import UIKit

protocol UserProfileHeaderVCDelegate: class {
    func didTapPortfolioLink(for user: User)
}

class UserProfileHeaderVC: UIViewController {

    let userProfilePic = UserProfilePic(frame: .zero)
    let userFullName = TextLabel(textAlignment: .left, fontSize: 25, fontWeight: .bold, textColor: .label)
    let locationImageView = UIImageView()
    let userLocation = TextLabel(textAlignment: .left, fontSize: 15, fontWeight: .medium, textColor: .label)
    let portfolioUrlImageView = UIImageView()
    let portfolioUrl = TextLabel(textAlignment: .left, fontSize: 15, fontWeight: .light, textColor: .label)
    let bioLabel = TextLabel(textAlignment: .left, fontSize: 15, fontWeight: .regular, textColor: .label)

    var user: User!
    weak var delegate: UserProfileHeaderVCDelegate!
    
    init(user: User, delegate: UserProfileHeaderVCDelegate) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubviews(userProfilePic, userFullName, locationImageView, userLocation, portfolioUrlImageView, portfolioUrl, bioLabel)
        configureUI()
        layoutUI()
    }
    
    func configurePortfolioUrl() {
        portfolioUrlImageView.image = SFSymbols.link
        portfolioUrlImageView.tintColor = .secondaryLabel
        portfolioUrl.text = user.portfolioUrl ?? "No Portfolio"
        portfolioUrl.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(portfolioUrlTapped))
        portfolioUrl.addGestureRecognizer(gestureRecognizer)
    }
    
    func configureUI() {
        configurePortfolioUrl()
        userProfilePic.downloadImage(fromURL: user.profileImage.large)
        
        userFullName.text = user.name
        
        locationImageView.image = SFSymbols.location
        locationImageView.tintColor = .secondaryLabel
        userLocation.text = user.location ?? "No Location"
        
        
        
        bioLabel.text = user.bio ?? "Empty Bio"
        bioLabel.numberOfLines = 4
    }
    
    @objc func portfolioUrlTapped() {
        delegate.didTapPortfolioLink(for: user)
    }
    
    func layoutUI(){
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        portfolioUrlImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        userProfilePic.topAnchor.constraint(equalTo: view.topAnchor),
        userProfilePic.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        userProfilePic.widthAnchor.constraint(equalToConstant: 90),
        userProfilePic.heightAnchor.constraint(equalToConstant: 90),
        
        userFullName.topAnchor.constraint(equalTo: view.topAnchor),
        userFullName.leadingAnchor.constraint(equalTo: userProfilePic.trailingAnchor, constant: 20),
        userFullName.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        userFullName.heightAnchor.constraint(equalToConstant: 30),
        
        locationImageView.topAnchor.constraint(equalTo: userFullName.bottomAnchor, constant: 10),
        locationImageView.leadingAnchor.constraint(equalTo: userProfilePic.trailingAnchor, constant: 20),
        locationImageView.widthAnchor.constraint(equalToConstant: 20),
        locationImageView.heightAnchor.constraint(equalToConstant: 20),

        userLocation.topAnchor.constraint(equalTo: userFullName.bottomAnchor, constant: 10),
        userLocation.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 5),
        userLocation.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        userLocation.heightAnchor.constraint(equalToConstant: 20),

        portfolioUrlImageView.bottomAnchor.constraint(equalTo: userProfilePic.bottomAnchor),
        portfolioUrlImageView.leadingAnchor.constraint(equalTo: userProfilePic.trailingAnchor, constant: 20),
        portfolioUrlImageView.widthAnchor.constraint(equalToConstant: 20),
        portfolioUrlImageView.heightAnchor.constraint(equalToConstant: 20),

        portfolioUrl.bottomAnchor.constraint(equalTo: userProfilePic.bottomAnchor),
        portfolioUrl.leadingAnchor.constraint(equalTo: portfolioUrlImageView.trailingAnchor, constant: 5),
        portfolioUrl.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        portfolioUrl.heightAnchor.constraint(equalToConstant: 20),
        
        bioLabel.topAnchor.constraint(equalTo: userProfilePic.bottomAnchor, constant: 10),
        bioLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        bioLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

}
