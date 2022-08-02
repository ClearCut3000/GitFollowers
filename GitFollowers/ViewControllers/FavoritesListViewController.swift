//
//  FavoritesListViewController.swift
//  GitFollowers
//
//  Created by Николай Никитин on 14.07.2022.
//

import UIKit

class FavoritesListViewController: GFDataLoadingViewController {

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

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    getFavorites()
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
    tableView.removeExcessCells()
    tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseID)
  }

  func getFavorites() {
    PersistanceManager.retriveFavorites { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success(let favorites):
        self.updateUI(with: favorites)
      case .failure(let error):
        self.presentGFAlertOnMailThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
      }
    }
  }

  func updateUI(with favorites: [Follower]) {
    if favorites.isEmpty {
      self.showEmptyStateView(with: "No favorites?\nAdd one on the follower screen.", in: self.view)
    }
    self.favorites = favorites
    DispatchQueue.main.async {
      self.tableView.reloadData()
      self.view.bringSubviewToFront(self.tableView)
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

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let favorite = favorites[indexPath.row]
    let destinationVC = FollowerListViewController(username: favorite.login)
    navigationController?.pushViewController(destinationVC, animated: true)
  }

  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    guard editingStyle == .delete else { return }
    let favorite = favorites[indexPath.row]

    PersistanceManager.update(with: favorite, actionType: .remove) { [weak self] error in
      guard let self = self else { return }
      guard let error = error else {
        self.favorites.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
        return
      }
      self.presentGFAlertOnMailThread(title: "Unable to delete favorite!", message: error.rawValue, buttonTitle: "OK")
    }
  }
}
