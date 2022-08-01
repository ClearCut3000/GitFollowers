//
//  GFFollowerItemViewController.swift
//  GitFollowers
//
//  Created by Николай Никитин on 24.07.2022.
//

import UIKit

protocol GFFollowerItemViewControllerDelegate: AnyObject {
  func didTapGetFollowers(for user: User)
}

class GFFollowerItemViewController: GFItemInfoViewController {
  
  //MARK: - Properties
  weak var delegate: GFFollowerItemViewControllerDelegate!
  
  //MARK: - Init's
  init(user: User, delegate: GFFollowerItemViewControllerDelegate) {
    super.init(user: user)
    self.delegate = delegate
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureItems()
  }
  
  //MARK: - Methods
  private func configureItems() {
    itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
    itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)
    actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
  }
  
  override func actionButtonTapped() {
    delegate.didTapGetFollowers(for: user)
  }
}
