//
//  FollowerListViewController.swift
//  GitFollowers
//
//  Created by Николай Никитин on 16.07.2022.
//

import UIKit

class FollowerListViewController: UIViewController {

  //MARK: - Properties
  enum Section {
    case main
  }
  var username: String!
  var followers: [Follower] = []
  var collectionView: UICollectionView!
  var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!

  //MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureViewController()
    configureCollectionView()
    getFollowers()
    configureDataSource()
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
    collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
    view.addSubview(collectionView)
    collectionView.backgroundColor = .systemBackground
    collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
  }

  func getFollowers() {
    NetworkManager.shared.getFollowers(for: username, page: 1) { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success(let followers):
        self.followers = followers
        self.updateData()
      case .failure(let error):
        self.presentGFAlertOnMailThread(title: "Bad stuff Happened", message: error.rawValue, buttonTitle: "OK")
      }
    }
  }

  func configureDataSource() {
    dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
      cell.set(follower: itemIdentifier)
      return cell
    })
  }

  func updateData() {
    var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
    snapshot.appendSections([.main])
    snapshot.appendItems(followers)
    DispatchQueue.main.async {
      self.dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
    }
  }
}
