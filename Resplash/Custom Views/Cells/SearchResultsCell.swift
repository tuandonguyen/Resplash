//
//  SearchResultsCell.swift
//  Resplash
//
//  Created by Tuan Nguyen on 7/27/20.
//  Copyright © 2020 Tuan Nguyen. All rights reserved.
//

import UIKit

class SearchResultsCell: UITableViewCell {

    static let reuseID = "SearchResultsCell"
    let userProfilePic = UserProfilePic(frame: .zero)
    let usernameLabel = UserNameLabel()
    let userFullNameLabel = UserNameLabel()
    
   override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(userInfo: User) {
        usernameLabel.text = userInfo.username
        userFullNameLabel.text = userInfo.name
        NetworkManager.shared.downloadImage(from: userInfo.profileImage.medium) { [weak self] (image) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.userProfilePic.image = image
            }
        }
    }
    
    private func configure() {
        addSubview(userProfilePic)
        addSubview(usernameLabel)
        addSubview(userFullNameLabel)
        NSLayoutConstraint.activate([
            userProfilePic.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            userProfilePic.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            userProfilePic.heightAnchor.constraint(equalToConstant: 60),
            userProfilePic.widthAnchor.constraint(equalToConstant: 60),
            
            userFullNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -5),
            userFullNameLabel.leadingAnchor.constraint(equalTo: userProfilePic.trailingAnchor, constant: 15),
            userFullNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
            userFullNameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            usernameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 5),
            usernameLabel.leadingAnchor.constraint(equalTo: userProfilePic.trailingAnchor, constant: 15),
            usernameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
            usernameLabel.heightAnchor.constraint(equalToConstant: 20)
            
        ])
        
    }

}
