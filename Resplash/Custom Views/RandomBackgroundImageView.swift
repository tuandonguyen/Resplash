//
//  RandomBackgroundImageView.swift
//  Resplash
//
//  Created by Tuan Nguyen on 7/24/20.
//  Copyright © 2020 Tuan Nguyen. All rights reserved.
//

import UIKit

class RandomBackgroundImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        NetworkManager.shared.getRandomImageInfo { (result) in
            switch result {
            case .success(let randomPhotoInfo):
                print(randomPhotoInfo.urls.full)
                NetworkManager.shared.downloadImage(from: randomPhotoInfo.urls.regular) { [weak self] image in
                    guard let self = self else { return }
                    DispatchQueue.main.async { self.image = image }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
