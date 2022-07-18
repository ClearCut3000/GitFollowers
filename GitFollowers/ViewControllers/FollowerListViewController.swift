//
//  FollowerListViewController.swift
//  GitFollowers
//
//  Created by Николай Никитин on 16.07.2022.
//

import UIKit

class FollowerListViewController: UIViewController {

  //MARK: - Properties
  var username: String!
  var collectionView: UICollectionView!

  //MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureViewController()
    configureCollectionView()
    getFollowers()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(false, animated: true)
  }

  //MARK: - Methods
  func configureViewController() {
    view.backgroundColor = .systemBackground
    navigationController?.navigationBar.prefersLargeTitles = true
  }

  func configureCollectionView() {
    collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
    view.addSubview(collectionView)
    collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
  }

  func getFollowers() {
    NetworkManager.shared.getFollowers(for: username, page: 1) { result in
      switch result {
      case .success(let followers):
        print (followers.count)
      case .failure(let error):
        self.presentGFAlertOnMailThread(title: "Bad stuff Happened", message: error.rawValue, buttonTitle: "OK")
      }
    }
  }
}
