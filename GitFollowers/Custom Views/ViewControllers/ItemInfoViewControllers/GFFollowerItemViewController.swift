//
//  GFFollowerItemViewController.swift
//  GitFollowers
//
//  Created by Николай Никитин on 24.07.2022.
//

import UIKit

class GFFollowerItemViewController: GFItemInfoViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  private func configureItems() {
    itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
    itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)
    actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
  }
}
