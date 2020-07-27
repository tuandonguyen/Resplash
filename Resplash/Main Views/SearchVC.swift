//
//  SearchVC.swift
//  UnsplashLikes
//
//  Created by admin on 7/23/20.
//  Copyright © 2020 Tuan Nguyen. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {
    
    let searchForUserTF = TextField()
    let backgroundImage = RandomBackgroundImageView(frame: .zero)
    var backgroundImageUserProfilePic = UserProfilePic(frame: .zero)
    let backgroundImageUserName = UserNameLabel()
    
    var username = "scottwebb"
    var page = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureBackgroundImage()
        configureBackgoundImageUserProfilePic()
        configureBackgroundImageUserName()
        configureTextField()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func configureTextField() {
        view.addSubview(searchForUserTF)
        searchForUserTF.delegate = self
        NSLayoutConstraint.activate([
            searchForUserTF.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            searchForUserTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            searchForUserTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            searchForUserTF.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    private func configureBackgroundImage() {
        view.addSubview(backgroundImage)
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            backgroundImage.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func configureBackgoundImageUserProfilePic() {
        view.addSubview(backgroundImageUserProfilePic)
        backgroundImageUserProfilePic.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundImageUserProfilePic.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            backgroundImageUserProfilePic.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: +50)
        ])
    }
    
    private func configureBackgroundImageUserName() {
        view.addSubview(backgroundImageUserName)
        backgroundImageUserName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundImageUserName.centerYAnchor.constraint(equalTo: backgroundImageUserProfilePic.centerYAnchor),
            backgroundImageUserName.leadingAnchor.constraint(equalTo: backgroundImageUserProfilePic.trailingAnchor, constant: 20),
            backgroundImageUserName.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}


//MARK: - TextField Delegate Methods

extension SearchVC: UITextFieldDelegate {
    //This delegate method triggers when the 'return' key is pressed.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //pushFollowerListVC()
        
        return true
    }
    
}
