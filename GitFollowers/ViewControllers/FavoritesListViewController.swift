//
//  FavoritesListViewController.swift
//  GitFollowers
//
//  Created by Николай Никитин on 14.07.2022.
//

import UIKit

class FavoritesListViewController: UIViewController {

  //MARK: - Properties
  var favorites: [Follower] = []

  //MARK: - Subviews
  let tableView = UITableView()

  //MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureViewController()
    configureTableView()
  }

  //MARK: - Methods
  func configureViewController() {
    view.backgroundColor = .systemBackground
    title = "Favorites"
    navigationController?.navigationBar.prefersLargeTitles = true
  }

  func configureTableView() {
    view.addSubview(tableView)
    tableView.frame = view.bounds
    tableView.rowHeight = 80
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseID)
  }

  func getFavorites() {
    PersistanceManager.retriveFaworites { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success(let favorites):
        if favorites.isEmpty {
          self.showEmptyStateView(with: "No favorites?\nAdd one on the follower screen.", in: self.view)
        }
        self.favorites = favorites
        DispatchQueue.main.async {
          self.tableView.reloadData()
          self.view.bringSubviewToFront(self.tableView)
        }
      case .failure(let error):
        self.presentGFAlertOnMailThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
      }
    }
  }
}

//MARK: - TableView DataSource&Delegate Protocols
extension FavoritesListViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return favorites.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseID) as! FavoriteCell
    let favorite = favorites[indexPath.row]
    cell.set(favorite: favorite)
    return cell
  }
}
