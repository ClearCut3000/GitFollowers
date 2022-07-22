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

  //MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
    navigationItem.rightBarButtonItem = doneButton
    layoutUI()
    NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .failure(let error):
        self.presentGFAlertOnMailThread(title: "Something went wrong with user data!", message: error.rawValue, buttonTitle: "OK")
      case .success(let user):
        DispatchQueue.main.async {
          self.add(childVC: GFUserInfoHeaderViewController(user: user), to: self.headerView)
        }
      }
    }
  }

  //MARK: - Methods
  func layoutUI() {
    view.addSubview(headerView)
    NSLayoutConstraint.activate([
      headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      headerView.heightAnchor.constraint(equalToConstant: 180)
    ])
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
