//
//  ViewController.swift
//  AppleMusicVideoSearchApp
//
//  Created by dave76 on 31/05/2019.
//  Copyright © 2019 dave76. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
  
  // MARK:- Properties
  
  var tracks: [Track] = []
  
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

  // MARK:- View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    tableView.dataSource = self
    tableView.delegate = self
    searchBar.delegate = self
    
    setupLayout()
  }

  // MARK:- setup Works
  
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
  

  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  func dismissKeyPad() {
    searchBar.resignFirstResponder()
  }
}

// MARK:- TableView DataSource

extension SearchViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tracks.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? ResultCell else {
      return UITableViewCell()
    }
    cell.configure(track: tracks[indexPath.row])
    return cell
  }
}

// MARK:- TableView Delegate

extension SearchViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 74
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    dismissKeyPad()
  }
}

// MARK:- SearchBar Delegate

extension SearchViewController: UISearchBarDelegate {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    dismissKeyPad()
    
    guard let searchText = searchBar.text, searchText.isEmpty == false else { return }
    let urlString = "https://itunes.apple.com/search?media=music&entity=musicVideo"
    var urlComponents = URLComponents(string: urlString)!
    let queryItem = URLQueryItem(name: "term", value: searchText)
    urlComponents.queryItems?.append(queryItem)
    
    guard let requestURL = urlComponents.url else { return }
    
    URLSession.shared.dataTask(with: requestURL) { [weak self] (data, response, error) in
      guard let strongSelf = self else { return }
      guard error == nil else { return }
      
      guard let statusCode = (response as? HTTPURLResponse)?.statusCode else { return }
      let successRange = 200..<300
      
      guard successRange.contains(statusCode) else { return }
      
      guard let resultData = data else { return }
      //print(resultData)
      strongSelf.tracks = strongSelf.parse(data: resultData) ?? []
      print(strongSelf.tracks)
      DispatchQueue.main.async {
        strongSelf.tableView.reloadData()
        strongSelf.tableView.setContentOffset(.zero, animated: false)
      }
    }.resume()
    
  }
  
  func position(for bar: UIBarPositioning) -> UIBarPosition {
    return .topAttached
  }
}

// MARK:- Extension - Parse Methods
extension SearchViewController {
  func parse(data: Data) -> [Track]? {
    do {
      let decoder = JSONDecoder()
      let response = try decoder.decode(Response.self, from: data)
      let trackList = response.results
      return trackList
    } catch let error {
      print(error.localizedDescription)
      return nil
    }
  }
}
