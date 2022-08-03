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

  //MARK: - Subviews
  var collectionView: UICollectionView!
  
  //MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()

    configureViewController()
    configureCollectionView()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    getRepos(for: Username.shared.username)
  }

  //MARK: - Methods
  func configureViewController() {
    view.backgroundColor = .systemBackground
    navigationController?.navigationBar.prefersLargeTitles = true
  }

  func configureCollectionView() {
    collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createOneColumnFlowLayout(in: view))
    collectionView.delegate = self
    collectionView.dataSource = self
    view.addSubview(collectionView)
    collectionView.backgroundColor = .systemBackground
    collectionView.register(RepoCell.self, forCellWithReuseIdentifier: RepoCell.reuseID)
  }

  func getRepos(for username: String) {
    showLoadingView()
    NetworkManager.shared.getRepos(for: username) { [weak self] result in
      guard let self = self else { return }
      self.dismissLoadinView()
      switch result {
      case .success(let repos):
        self.repos = repos
        DispatchQueue.main.async {
          self.collectionView.reloadData()
        }
      case .failure(let error):
        self.presentGFAlertOnMailThread(title: "Bad stuff Happened", message: error.rawValue, buttonTitle: "OK")
      }
    }
  }
}

//MARK: - UICollectionViewDelegate Protocol
extension ReposListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return repos.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RepoCell.reuseID, for: indexPath) as! RepoCell
    let repo = repos[indexPath.row]
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
}
