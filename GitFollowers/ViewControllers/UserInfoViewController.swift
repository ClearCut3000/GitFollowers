//
//  UserInfoViewController.swift
//  GitFollowers
//
//  Created by Николай Никитин on 21.07.2022.
//

import UIKit

class UserInfoViewController: UIViewController {

  //MARK: - Properties
  var username: String!

  //MARK: - Subviews
  let headerView = UIView()
  let itemViewOne = UIView()
  let itemViewTwo = UIView()
  var itemViews: [UIView] = []

  //MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    confifureViewController()
    layoutUI()
    getUserInfo()
  }

  //MARK: - Methods
  func layoutUI() {
    let padding:CGFloat = 20
    itemViews = [headerView, itemViewOne, itemViewTwo]
    for itemView in itemViews {
      view.addSubview(itemView)
      itemView.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
        itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
      ])
    }
    let itemHeight: CGFloat = 140
    NSLayoutConstraint.activate([
      headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      headerView.heightAnchor.constraint(equalToConstant: 180),

      itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
      itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),

      itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
      itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight)
    ])
  }

  func getUserInfo() {
    NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .failure(let error):
        self.presentGFAlertOnMailThread(title: "Something went wrong with user data!", message: error.rawValue, buttonTitle: "OK")
      case .success(let user):
        DispatchQueue.main.async {
          self.add(childVC: GFUserInfoHeaderViewController(user: user), to: self.headerView)
          self.add(childVC: GFRepoItemViewController(user: user), to: self.itemViewOne)
          self.add(childVC: GFFollowerItemViewController(user: user), to: self.itemViewTwo)
        }
      }
    }
  }

  func confifureViewController() {
    view.backgroundColor = .systemBackground
    let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
    navigationItem.rightBarButtonItem = doneButton
  }

  func add(childVC: UIViewController, to containerView: UIView) {
    addChild(childVC)
    containerView.addSubview(childVC.view)
    childVC.view.frame = containerView.bounds
    childVC.didMove(toParent: self)
  }

  @objc func dismissVC() {
    dismiss(animated: true, completion: nil)
  }
}
