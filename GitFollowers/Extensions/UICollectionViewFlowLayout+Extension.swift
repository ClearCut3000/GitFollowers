//
//  UICollectionViewFlowLayout+Extension.swift
//  GitFollowers
//
//  Created by Николай Никитин on 31.07.2022.
//

import UIKit

extension UICollectionViewFlowLayout {
  override open func shouldInvalidateLayout(forPreferredLayoutAttributes preferredAttributes: UICollectionViewLayoutAttributes, withOriginalAttributes originalAttributes: UICollectionViewLayoutAttributes) -> Bool {
    return true
  }
}
