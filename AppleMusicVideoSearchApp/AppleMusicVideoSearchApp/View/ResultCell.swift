//
//  ResultCell.swift
//  AppleMusicVideoSearchApp
//
//  Created by dave76 on 31/05/2019.
//  Copyright © 2019 dave76. All rights reserved.
//

import UIKit

class ResultCell: UITableViewCell {
  
  // MARK:- Properties
  
  let titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Title"
    label.font = .boldSystemFont(ofSize: 20)
    label.numberOfLines = 0
    label.lineBreakMode = NSLineBreakMode.byWordWrapping
    label.textColor = .black
    return label
  }()
  
  let artisNameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Artist Name"
    label.font = .systemFont(ofSize: 12)
    label.textColor = .lightGray
    label.numberOfLines = 0
    return label
  }()
  
  // MARK:- Initializser
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    selectionStyle = .none
    setupLayout()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK:- private method
  
  fileprivate func setupLayout() {
    addSubview(titleLabel)
    addSubview(artisNameLabel)
    titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
    titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
    titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
    titleLabel.bottomAnchor.constraint(equalTo: artisNameLabel.topAnchor, constant: -5).isActive = true
    artisNameLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
    artisNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
  }
  
  func configure(track: Track) {
    titleLabel.text = track.title
    artisNameLabel.text = track.artistName
  }
}
