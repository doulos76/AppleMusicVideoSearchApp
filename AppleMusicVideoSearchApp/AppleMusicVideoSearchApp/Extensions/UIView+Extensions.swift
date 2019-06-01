//
//  UIView+Extensions.swift
//  AppleMusicVideoSearchApp
//
//  Created by dave76 on 01/06/2019.
//  Copyright © 2019 dave76. All rights reserved.
//

import UIKit

extension UIColor {
  static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
    return .init(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1)
  }
}
