//
//  GFRepoItemViewController.swift
//  GitFollowers
//
//  Created by Николай Никитин on 24.07.2022.
//

import UIKit

class GFRepoItemViewController: GFItemInfoViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  private func configureItems() {
    itemInfoViewOne.set(itemInfoType: .repos, withCount: user.publicRepos)
    itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.publicGists)
    actionButton.set(backgroundColor: .systemPurple, title: "GitHub Profile")
  }
}
