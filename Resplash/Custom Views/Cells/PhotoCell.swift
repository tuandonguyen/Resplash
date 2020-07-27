//
//  PhotoCell.swift
//  Resplash
//
//  Created by Tuan Nguyen on 7/26/20.
//  Copyright © 2020 Tuan Nguyen. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    static let reuseID = "PhotoCell"
    let photoImageView = UIImageView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(photoInfo: PhotoInfo) {
        NetworkManager.shared.downloadImage(from: photoInfo.urls.small) { [weak self] (image) in
            guard let self = self else { return }
            DispatchQueue.main.async { self.photoImageView.image = image }
        }
    }
    
    private func configure() {
        contentView.addSubview(photoImageView)
        photoImageView.contentMode = .scaleAspectFit
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        photoImageView.clipsToBounds = true
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
