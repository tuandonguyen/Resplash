//
//  UserProfilePic.swift
//  Resplash
//
//  Created by Tuan Nguyen on 7/24/20.
//  Copyright © 2020 Tuan Nguyen. All rights reserved.
//

import UIKit

class UserProfilePic: UIImageView {
    
    let cache = NetworkManager.shared.cache
    let placeholderImage = SFSymbols.profilePicPlaceholder
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .systemBackground
        layer.cornerRadius = 16
        clipsToBounds = true
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func downloadImage(fromURL url: String) {
        NetworkManager.shared.downloadImage(from: url) { [weak self] (image) in
            guard let self = self else { return }
            DispatchQueue.main.async { self.image = image }
        }
    }
}

