//
//  UIView+Extension.swift
//  GitFollowers
//
//  Created by Николай Никитин on 28.07.2022.
//

import UIKit

extension UIView {

  func addSubviews(_ views: UIView...) {
    for view in views {
      addSubview(view)
    }
  }
}
