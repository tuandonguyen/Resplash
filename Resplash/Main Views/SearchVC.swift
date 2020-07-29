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
    let backgroundImage = UIImageView(frame: .zero)
    var backgroundImageUserProfilePic = UserProfilePic(frame: .zero)
    let backgroundImageUserName = TextLabel(textAlignment: .left, fontSize: 15, fontWeight: .regular, textColor: .white)
    
    var username = ""
    var page = 1
    
    //true if text is in search field.
    //false if search field is empty
    var isUsernameEntered: Bool {
        return !searchForUserTF.text!.isEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        getRandomImageInfo()
        configureBackgroundImage()
        configureBackgoundImageUserProfilePic()
        configureBackgroundImageUserName()
        configureSearchField()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchForUserTF.text = ""
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    
    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    
    private func configureSearchField() {
        view.addSubview(searchForUserTF)
        searchForUserTF.delegate = self
        
        NSLayoutConstraint.activate([
            searchForUserTF.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            searchForUserTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            searchForUserTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            searchForUserTF.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    func getRandomImageInfo() {
        NetworkManager.shared.getRandomImageInfo { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let photoInfo):
                self.username = photoInfo.user.username
                //Set user full name.
                DispatchQueue.main.async {
                    self.backgroundImageUserName.text = photoInfo.user.name
                }
                //Download & set random background image.
                NetworkManager.shared.downloadImage(from: photoInfo.urls.regular) { [weak self] image in
                    guard let self = self else { return }
                    DispatchQueue.main.async { self.backgroundImage.image = image }
                }
                //Download and set user profile image.
                self.backgroundImageUserProfilePic.downloadImage(fromURL: photoInfo.user.profileImage.medium)
            case .failure(let error):
                print(error.rawValue)
            }
        }
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
        
        backgroundImageUserProfilePic.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(pushUserProfileVC))
        backgroundImageUserProfilePic.addGestureRecognizer(gestureRecognizer)
        
        NSLayoutConstraint.activate([
            backgroundImageUserProfilePic.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15),
            backgroundImageUserProfilePic.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15)
        ])
    }
    
    private func configureBackgroundImageUserName() {
        view.addSubview(backgroundImageUserName)
        backgroundImageUserName.translatesAutoresizingMaskIntoConstraints = false
        
        backgroundImageUserName.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(pushUserProfileVC))
        backgroundImageUserName.addGestureRecognizer(gestureRecognizer)
        
        NSLayoutConstraint.activate([
            backgroundImageUserName.centerYAnchor.constraint(equalTo: backgroundImageUserProfilePic.centerYAnchor),
            backgroundImageUserName.leadingAnchor.constraint(equalTo: backgroundImageUserProfilePic.trailingAnchor, constant: 15),
            backgroundImageUserName.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func pushUserProfileVC() {
        let userProfileVC = UserProfileVC(username: self.username)
        navigationController?.pushViewController(userProfileVC, animated: true)
    }
}


//MARK: - TextField Delegate Methods

extension SearchVC: UITextFieldDelegate {
    //This delegate method triggers when the 'return' key is pressed.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if isUsernameEntered {
            searchForUserTF.resignFirstResponder()
            let searchResultsVC = SearchResultsVC(searchQuery: searchForUserTF.text!)
            navigationController?.pushViewController(searchResultsVC, animated: true)
        } else {
            print("Please enter username")
        }
        return true
    }
    
}
