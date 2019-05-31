//
//  Response.swift
//  AppleMusicVideoSearchApp
//
//  Created by dave76 on 31/05/2019.
//  Copyright © 2019 dave76. All rights reserved.
//

import Foundation

struct Response: Codable {
  let resultCount: Int
  let results: [Track]
}
