//
//  SearchVC.swift
//  UnsplashLikes
//
//  Created by admin on 7/23/20.
//  Copyright © 2020 Tuan Nguyen. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {
    
    let searchButton = Button(backgroundColor: .systemBlue, title: "Find User")
    let randomButton = Button(backgroundColor: .systemGray, title: "Find Random Photo")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureSearchButton()
        configureRandomButton()
    }

    private func configureSearchButton() {
        searchButton.addTarget(self, action: #selector(testNetworkCall), for: .touchUpInside )
        view.addSubview(searchButton)
        NSLayoutConstraint.activate([
            searchButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            searchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            searchButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureRandomButton() {
        randomButton.addTarget(self, action: #selector(testNetworkCall), for: .touchUpInside )
        view.addSubview(randomButton)
        NSLayoutConstraint.activate([
            randomButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            randomButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            randomButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            randomButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func testNetworkCall() {
        NetworkManager.shared.getRandomImage { (result) in
            //guard let self = self else { return }
            switch result {
            case .success(let randomPhoto):
                print(randomPhoto)
            case .failure(let error):
                print(error.rawValue)
            }
        }
        
    }
}
