//
//  ReposListViewController.swift
//  GitFollowers
//
//  Created by Николай Никитин on 02.08.2022.
//

import UIKit

protocol ReposListViewControllerDelegate: AnyObject {
  func didRequestRepos(for username: String)
}

class ReposListViewController: GFDataLoadingViewController {

  //MARK: - Properties
  var username: String!
  var repos: [Repo] = []
  weak var delegate: ReposListViewControllerDelegate!

  //MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureViewController()
  }

  //MARK: - Methods
  func configureViewController() {
    view.backgroundColor = .systemBackground
    navigationController?.navigationBar.prefersLargeTitles = true
  }

  func getRepos(for username: String) {
    showLoadingView()
    NetworkManager.shared.getRepos(for: username) { [weak self] result in
      guard let self = self else { return }
      self.dismissLoadinView()
      switch result {
      case .success(let repos):
        self.repos = repos
        print(self.repos.count)
      case .failure(let error):
        self.presentGFAlertOnMailThread(title: "Bad stuff Happened", message: error.rawValue, buttonTitle: "OK")
      }
    }
  }
}
