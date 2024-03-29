//
//  GFItemInfoViewController.swift
//  GitFollowers
//
//  Created by Николай Никитин on 23.07.2022.
//

import UIKit

class GFItemInfoViewController: UIViewController {
  
  var user: User!
  
  //MARK: - Subviews
  let stackView = UIStackView()
  let itemInfoViewOne = GFItemInfoView()
  let itemInfoViewTwo = GFItemInfoView()
  let actionButton = GFButton()
  
  //MARK: - Init's
  init(user: User) {
    super.init(nibName: nil, bundle: nil)
    self.user = user
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureBackgroundView()
    layoutUI()
    configureStackView()
    configureActionButton()
  }
  
  //MARK: - UI Methods
  func configureBackgroundView() {
    view.layer.cornerRadius = 18
    view.backgroundColor = .secondarySystemBackground
  }
  
  private func layoutUI() {
    view.addSubviews(stackView, actionButton)
    stackView.translatesAutoresizingMaskIntoConstraints = false
    let padding: CGFloat = 20
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
      stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
      stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
      stackView.heightAnchor.constraint(equalToConstant: 50),
      
      actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
      actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
      actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
      actionButton.heightAnchor.constraint(equalToConstant: 44)
    ])
  }
  
  private func configureStackView() {
    stackView.axis = .horizontal
    stackView.distribution = .equalSpacing
    stackView.addArrangedSubview(itemInfoViewOne)
    stackView.addArrangedSubview(itemInfoViewTwo)
  }
  
  private func configureActionButton() {
    actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
  }
  
  @objc func actionButtonTapped() {}
}
