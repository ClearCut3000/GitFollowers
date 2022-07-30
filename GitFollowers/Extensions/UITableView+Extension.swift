//
//  UITableView+Extension.swift
//  GitFollowers
//
//  Created by Николай Никитин on 30.07.2022.
//

import UIKit

extension UITableView {

  func reloadDataOnMainThread() {
    DispatchQueue.main.async {
      self.reloadData()
    }
  }

  func removeExcessCells() {
    tableFooterView = UIView(frame: .zero)
  }
}
