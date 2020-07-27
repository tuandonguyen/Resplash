//
//  SearchResultsVC.swift
//  Resplash
//
//  Created by Tuan Nguyen on 7/27/20.
//  Copyright © 2020 Tuan Nguyen. All rights reserved.
//

import UIKit

class SearchResultsVC: UIViewController {
    
    var searchQuery: String = ""
    let tableView = UITableView()
    var searchResults: [User] = []
    let page = 1

    //custom initializer to take in search query
    init(searchQuery: String) {
        super.init(nibName: nil, bundle: nil)
        self.searchQuery = searchQuery
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserSearchResults(for: searchQuery, page: page)
        configureViewController()
        configureTableView()
    }
    
    func getUserSearchResults(for searchQuery: String, page: Int) {
        NetworkManager.shared.userSearchQuery(for: searchQuery, page: page) { (result) in
            switch result {
            case .success(let searchResults):
                self.searchResults = searchResults.results
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "Users Found"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureTableView() {
        //add the table view to the FavoritesListVC
        view.addSubview(tableView)
        //stretch the table view to the entire screen/favoriteslistvc
        tableView.frame = view.bounds
        //each row in tableView is 80 pnts high.
        tableView.rowHeight = 80
        
        tableView.delegate = self
        tableView.dataSource = self
        //removes blank cells
        //tableView.removeExcessCells()
        
        //Register our cell to the tableView
        tableView.register(SearchResultsCell.self, forCellReuseIdentifier: SearchResultsCell.reuseID)
    }
    
    
    
}

//MARK: - Tableview Datasource Methods

extension SearchResultsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultsCell.reuseID) as! SearchResultsCell
        let eachUser = searchResults[indexPath.row]
        print(eachUser)
        print(searchResults.count)
        cell.set(userInfo: eachUser)
        return cell
    }
    
    
}

//MARK: - Tableview Delegate Methods

extension SearchResultsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = searchResults[indexPath.row]
        let destVC = UserProfileVC(username: user.username)
        navigationController?.pushViewController(destVC, animated: true)
    }
}
