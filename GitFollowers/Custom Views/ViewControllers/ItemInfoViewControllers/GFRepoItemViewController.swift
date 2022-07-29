//
//  GFRepoItemViewController.swift
//  GitFollowers
//
//  Created by Николай Никитин on 24.07.2022.
//

import UIKit

protocol GFRepoItemViewControllerDelegate: AnyObject {
  func didTapGitHubProfile(for user: User)
}

class GFRepoItemViewController: GFItemInfoViewController {
  
  //MARK: - Properties
  weak var delegate: GFRepoItemViewControllerDelegate!
  
  //MARK: - Init's
  init(user: User, delegate: GFRepoItemViewControllerDelegate) {
    super.init(user: user)
    self.delegate = delegate
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  //MARK: - Methods
  private func configureItems() {
    itemInfoViewOne.set(itemInfoType: .repos, withCount: user.publicRepos)
    itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.publicGists)
    actionButton.set(backgroundColor: .systemPurple, title: "GitHub Profile")
  }
  
  override func actionButtonTapped() {
    delegate.didTapGitHubProfile(for: user)
  }
}
