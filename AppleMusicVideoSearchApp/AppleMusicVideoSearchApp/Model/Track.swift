//
//  Track.swift
//  AppleMusicVideoSearchApp
//
//  Created by dave76 on 31/05/2019.
//  Copyright © 2019 dave76. All rights reserved.
//

import Foundation

struct Track: Codable {
  let title: String
  let artistName: String
  let thumbnail: String
  let previewUrl: String
  
  enum CodingKeys: String, CodingKey {
    case title = "trackName"
    case artistName = "artistName"
    case thumbnail = "artworkUrl30"
    case previewUrl = "previewUrl"    
  }
}
