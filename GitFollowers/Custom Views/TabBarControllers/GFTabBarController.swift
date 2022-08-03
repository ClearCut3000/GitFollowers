//
//  GFTabBarController.swift
//  GitFollowers
//
//  Created by Николай Никитин on 27.07.2022.
//

import UIKit

class GFTabBarController: UITabBarController {
  
  //MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    UITabBar.appearance().tintColor = .systemGreen
    viewControllers = [createSearchNavigationController(), createFavoritesNavigationController(), createReposListViewController()]
  }
  
  //MARK: - Methods
  func createSearchNavigationController() -> UINavigationController {
    let searchViewController = SearchViewController()
    searchViewController.title = "Search"
    searchViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
    return UINavigationController(rootViewController: searchViewController)
  }
  
  func createFavoritesNavigationController() -> UINavigationController {
    let favoritesListViewController = FavoritesListViewController()
    favoritesListViewController.title = "Favorites"
    favoritesListViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
    return UINavigationController(rootViewController: favoritesListViewController)
  }

  func createReposListViewController() -> UINavigationController {
    let reposListViewController = ReposListViewController()
    reposListViewController.title = "Repositories"
    reposListViewController.tabBarItem = UITabBarItem(title: "Repositories", image: SFSymbols.repo, tag: 2)
    return UINavigationController(rootViewController: reposListViewController)
  }
}
