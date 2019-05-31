//
//  ViewController.swift
//  AppleMusicVideoSearchApp
//
//  Created by dave76 on 31/05/2019.
//  Copyright © 2019 dave76. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
  
  let cellId = "cellId"
  
  let searchBar: UISearchBar = {
    let searchBar = UISearchBar()
    searchBar.barTintColor = UIColor(red: 229 / 255, green: 38 / 255, blue: 89 / 255, alpha: 1)
    searchBar.translatesAutoresizingMaskIntoConstraints = false
    return searchBar
  }()
  
  let tableView: UITableView = {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    return tableView
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    tableView.dataSource = self
    tableView.delegate = self
    
    setupLayout()
  }

  fileprivate func setupLayout() {
    
    tableView.register(ResultCell.self, forCellReuseIdentifier: cellId)
    
    view.addSubview(searchBar)
    view.addSubview(tableView)
    
    searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    
    tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
    tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
  }
  

}

// MARK:- TableView DataSource

extension SearchViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ResultCell
    
    return cell
  }
}

// MARK:- TableView Delegate

extension SearchViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 74
  }
}
