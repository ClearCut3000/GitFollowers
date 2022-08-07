//
//  ReposListViewController.swift
//  GitFollowers
//
//  Created by Николай Никитин on 02.08.2022.
//

import UIKit

class ReposListViewController: GFDataLoadingViewController {

  //MARK: - Properties
  var repos: [Repo] = []
  var filteredRepos: [Repo] = []
  var page: Int = 1
  var hasMoreRepos = true
  var isLoadingMoreRepos = false
  var username: String = ""
  var isSearching = false

  //MARK: - Subviews
  var collectionView: UICollectionView!
  
  //MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureViewController()
    configureSearchController()
    configureCollectionView()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    usernameCheck()
  }

  //MARK: - Methods
  func configureViewController() {
    view.backgroundColor = .systemBackground
    navigationController?.navigationBar.prefersLargeTitles = true
  }

  func configureSearchController() {
    let searchController = UISearchController()
    searchController.searchResultsUpdater = self
    searchController.searchBar.delegate = self
    searchController.searchBar.placeholder = "Search for a repository..."
    searchController.obscuresBackgroundDuringPresentation = false
    navigationItem.searchController = searchController
  }

  func configureCollectionView() {
    collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createOneColumnFlowLayout(in: view))
    collectionView.delegate = self
    collectionView.dataSource = self
    view.addSubview(collectionView)
    collectionView.backgroundColor = .systemBackground
    collectionView.register(RepoCell.self, forCellWithReuseIdentifier: RepoCell.reuseID)
  }

  func usernameCheck() {
    guard Username.shared.username != nil else {
      self.showEmptyStateView(with: "No username entered", in: self.view)
      return
    }
    if username != Username.shared.username {
      username = Username.shared.username!
      self.repos.removeAll()
      self.collectionView.reloadDataOnMainThread()
      getRepos(for: username, page: page)
      self.view.bringSubviewToFront(collectionView)
    }
  }

  func getRepos(for username: String, page: Int) {
    showLoadingView()
    isLoadingMoreRepos = true
    NetworkManager.shared.getRepos(for: username, page: page) { [weak self] result in
      guard let self = self else { return }
      self.dismissLoadinView()
      switch result {
      case .success(let repos):
        self.updateUI(with: repos)
      case .failure(let error):
        self.presentGFAlertOnMailThread(title: "Bad stuff Happened", message: error.rawValue, buttonTitle: "OK")
      }
      self.isLoadingMoreRepos = false
    }
  }

  func updateUI(with repos: [Repo]) {
    if repos.count < 100 {
      self.hasMoreRepos = false
    }
    self.repos.append(contentsOf: repos)
    if self.repos.isEmpty {
      let message = "This user doesn't have any repositories. So sad!"
      DispatchQueue.main.async {
        self.showEmptyStateView(with: message, in: self.view)
        return
      }
    }
    collectionView.reloadDataOnMainThread()
  }
}

//MARK: - Search Protocol's
extension ReposListViewController: UISearchResultsUpdating, UISearchBarDelegate {
  func updateSearchResults(for searchController: UISearchController) {
    guard let filter = searchController.searchBar.text, !filter.isEmpty else {
      isSearching = false
      return
    }
    isSearching = true
    filteredRepos = repos.filter { $0.name.lowercased().contains(filter.lowercased()) }
    collectionView.reloadDataOnMainThread()
  }

  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    isSearching = false
    collectionView.reloadDataOnMainThread()
  }
}

//MARK: - UICollectionViewDelegate Protocol
extension ReposListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return isSearching ? filteredRepos.count : repos.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RepoCell.reuseID, for: indexPath) as! RepoCell
    let repo = isSearching ? filteredRepos[indexPath.row] : repos[indexPath.row]
    cell.set(repo: repo)
    return cell
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let selectedRepo = repos[indexPath.row]
    guard let url = URL(string: selectedRepo.htmlUrl ) else {
      presentGFAlertOnMailThread(title: "Invalid URL", message: "The URL attached to this user is invalid.", buttonTitle: "OK")
      return
    }
    presentSafariVC(with: url)
  }

  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    let offsetY = scrollView.contentOffset.y
    let contentHeight = scrollView.contentSize.height
    let height = scrollView.frame.size.height
    if offsetY > contentHeight - height {
      guard hasMoreRepos, !isLoadingMoreRepos else { return }
      page += 1
      guard let username = Username.shared.username else { return }
      getRepos(for: username, page: page)
    }
  }
}
