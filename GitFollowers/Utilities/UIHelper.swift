//
//  UIHelper.swift
//  GitFollowers
//
//  Created by Николай Никитин on 20.07.2022.
//

import UIKit

enum UIHelper {

  static func createThreeColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
    let width = view.bounds.width
    let padding: CGFloat = 12
    let minimumItemsSpacing: CGFloat  = 10
    let availableWidth = width - (padding * 2) - (minimumItemsSpacing * 2)
    let itemWidth = availableWidth / 3
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
    flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
    return flowLayout
  }

  static func createOneColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
    let width = view.bounds.width
    let minimumItemsSpacing: CGFloat  = 10
    let padding: CGFloat = 16
    let itemWidth = width - (padding * 2) - (minimumItemsSpacing * 2)
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
    flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth / 3 )
    return flowLayout
  }
}
