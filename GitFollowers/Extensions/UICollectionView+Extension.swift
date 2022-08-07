//
//  UICollectionView+Extension.swift
//  GitFollowers
//
//  Created by Николай Никитин on 07.08.2022.
//

import UIKit

extension UICollectionView {

  func reloadDataOnMainThread() {
    DispatchQueue.main.async {
      self.reloadData()
    }
  }
}
