//
//  UserInfoViewController.swift
//  GitFollowers
//
//  Created by Николай Никитин on 21.07.2022.
//

import UIKit

protocol UserInfoViewControllerDelegate: AnyObject {
  func didRequestFollowers(for username: String)
}

class UserInfoViewController: GFDataLoadingViewController {

  //MARK: - Properties
  var username: String!
  weak var delegate: UserInfoViewControllerDelegate!

  //MARK: - Subviews
  let headerView = UIView()
  let itemViewOne = UIView()
  let itemViewTwo = UIView()
  let dateLabel = GFBodyLabel(textAlignment: .center)
  var itemViews: [UIView] = []
  let scrollView = UIScrollView()
  let contentView = UIView()

  //MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    confifureViewController()
    configureScrollView()
    layoutUI()
    getUserInfo()
  }

  //MARK: - Methods
  func configureScrollView() {
    view.addSubview(scrollView)
    scrollView.addSubview(contentView)
    scrollView.pinToEdges(of: view)
    contentView.pinToEdges(of: scrollView)
    NSLayoutConstraint.activate([
      contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
      contentView.heightAnchor.constraint(equalToConstant: 600)
    ])
  }

  func configureUIElements(with user: User) {
    self.add(childVC: GFUserInfoHeaderViewController(user: user), to: self.headerView)
    self.add(childVC: GFRepoItemViewController(user: user, delegate: self), to: self.itemViewOne)
    self.add(childVC: GFFollowerItemViewController(user: user, delegate: self), to: self.itemViewTwo)
    self.dateLabel.text = "GitHub sinse \(user.createdAt.convertToMonthYearFormat())"
  }

  func layoutUI() {
    let padding:CGFloat = 20
    itemViews = [headerView, itemViewOne, itemViewTwo, dateLabel]
    for itemView in itemViews {
      contentView.addSubview(itemView)
      itemView.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        itemView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
        itemView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding)
      ])
    }
    let itemHeight: CGFloat = 140
    NSLayoutConstraint.activate([
      headerView.topAnchor.constraint(equalTo: contentView.topAnchor),
      headerView.heightAnchor.constraint(equalToConstant: 210),

      itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
      itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),

      itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
      itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),

      dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
      dateLabel.heightAnchor.constraint(equalToConstant: 50)
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
          self.configureUIElements(with: user)
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

//MARK: - GFRepoItemViewControllerDelegate Communication Protocol
extension UserInfoViewController: GFRepoItemViewControllerDelegate {
  func didTapGitHubProfile(for user: User) {
    guard let url = URL(string: user.htmlUrl) else {
      presentGFAlertOnMailThread(title: "Invalid URL", message: "The URL attached to this user is invalid.", buttonTitle: "OK")
      return
    }
    presentSafariVC(with: url)
  }
}

//MARK: - GFFollowerItemViewControllerDelegate Communication Protocol
extension UserInfoViewController: GFFollowerItemViewControllerDelegate {
  func didTapGetFollowers(for user: User) {
    guard user.followers != 0 else {
      presentGFAlertOnMailThread(title: "No followers!", message: "Thise user has no followers!", buttonTitle: "OK")
      return
    }
    delegate.didRequestFollowers(for: user.login)
    dismissVC()
  }
}


