//
//  FollowerListViewController.swift
//  GitFollowers
//
//  Created by Николай Никитин on 16.07.2022.
//

import UIKit

class FollowerListViewController: GFDataLoadingViewController {

  //MARK: - Properties
  enum Section { case main }
  var username: String!
  var followers: [Follower] = []
  var filteredFollowers: [Follower] = []
  var page = 1
  var hasMoreFollowers = true
  var isSearching = false
  var collectionView: UICollectionView!
  var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
  var isLoadingMoreFollowers = false

  //MARK: - Init's
  init(username: String) {
    super.init(nibName: nil, bundle: nil)
    self.username = username
    title = username
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  //MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureViewController()
    configureSearchController()
    configureCollectionView()
    getFollowers(username: username, page: page)
    configureDataSource()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(false, animated: true)
  }

  //MARK: - Methods
  func configureSearchController() {
    let searchController = UISearchController()
    searchController.searchResultsUpdater = self
    searchController.searchBar.placeholder = "Search for a username..."
    searchController.obscuresBackgroundDuringPresentation = false
    navigationItem.searchController = searchController
  }

  func configureViewController() {
    view.backgroundColor = .systemBackground
    navigationController?.navigationBar.prefersLargeTitles = true
    let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
    navigationItem.rightBarButtonItem = addButton
  }

  func configureCollectionView() {
    collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
    view.addSubview(collectionView)
    collectionView.delegate = self
    collectionView.backgroundColor = .systemBackground
    collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
  }

  func getFollowers(username: String, page: Int) {
    showLoadingView()
    isLoadingMoreFollowers = true
    NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
      guard let self = self else { return }
      self.dismissLoadinView()
      switch result {
      case .success(let followers):
        if followers.count < 100 {
          self.hasMoreFollowers = false
        }
        self.followers.append(contentsOf: followers)
        if self.followers.isEmpty {
          let message = "This user doesn't have any followrs. Go follow them!"
          DispatchQueue.main.async {
            self.showEmptyStateView(with: message, in: self.view)
            return
          }
        }
        self.updateData(on: self.followers)
      case .failure(let error):
        self.presentGFAlertOnMailThread(title: "Bad stuff Happened", message: error.rawValue, buttonTitle: "OK")
      }
      self.isLoadingMoreFollowers = false
    }
  }

  func configureDataSource() {
    dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { collectionView, indexPath, follower in
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
        cell.set(follower: follower)
        return cell
    })
  }

  func updateData(on followers: [Follower]) {
    var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
    snapshot.appendSections([.main])
    snapshot.appendItems(followers)
    DispatchQueue.main.async {
      self.dataSource.apply(snapshot, animatingDifferences: true)
    }
  }

  @objc func addButtonTapped() {
    showLoadingView()
    NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
      guard let self = self else { return }
      self.dismissLoadinView()
      switch result {
      case .success(let user):
        let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
        PersistanceManager.update(with: favorite, actionType: .add) { [weak self] error in
          guard let self = self else { return }
          guard let error = error else {
            self.presentGFAlertOnMailThread(title: "Success!", message: "You have succesfully fovorited this user!", buttonTitle: "OK")
            return
          }
          self.presentGFAlertOnMailThread(title: "Something went wrong>.", message: error.rawValue, buttonTitle: "OK")
        }
      case .failure(let error):
        self.presentGFAlertOnMailThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
      }
    }
  }
}

//MARK: - CollectionView Delegate Protocol
extension FollowerListViewController: UICollectionViewDelegate {
  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    let offsetY = scrollView.contentOffset.y
    let contentHeight = scrollView.contentSize.height
    let height = scrollView.frame.size.height
    if offsetY > contentHeight - height {
      guard hasMoreFollowers, !isLoadingMoreFollowers else { return }
      page += 1
      getFollowers(username: username, page: page)
    }
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let activeArray = isSearching ? filteredFollowers : followers
    let follower = activeArray[indexPath.item]
    let destinationVC = UserInfoViewController()
    destinationVC.username = follower.login
    destinationVC.delegate = self
    let navigationController = UINavigationController(rootViewController: destinationVC)
    present(navigationController, animated: true, completion: nil)
  }


}

//MARK: - Search Protocol
extension FollowerListViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    guard let filter = searchController.searchBar.text, !filter.isEmpty else {
      filteredFollowers.removeAll()
      updateData(on: followers)
      isSearching = false
      return
    }
    isSearching = true
    filteredFollowers = followers.filter { $0.login.lowercased().contains(filter.lowercased()) }
    updateData(on: filteredFollowers)
  }
}

//MARK: - UserInfoViewControllerDelegate Protocol
extension FollowerListViewController: UserInfoViewControllerDelegate {
  func didRequestFollowers(for username: String) {
    self.username = username
    title = username
    page = 1
    followers.removeAll()
    filteredFollowers.removeAll()
    collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
    getFollowers(username: username, page: page)
  }
}
