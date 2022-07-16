//
//  GFAlertViewController.swift
//  GitFollowers
//
//  Created by Николай Никитин on 17.07.2022.
//

import UIKit

class GFAlertViewController: UIViewController {

  //MARK: - Properties
  var alertTitle: String?
  var message: String?
  var buttonTitle: String?

  let padding: CGFloat = 20

  //MARK: - Subviews
  let containerView = UIView()
  let titleLabel = GFTitleLabel(textAlignment: .center, fontSize: 20)
  let messageLabel = GFBodyLabel(textAlignment: .center)
  let actionButton = GFButton(backgroundColor: .systemPink, title: "OK")

  //MARK: - Init's
  init(title: String, message: String, buttonTitle: String) {
    super.init(nibName: nil, bundle: nil)
    self.alertTitle = title
    self.message = message
    self.buttonTitle = buttonTitle
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  //MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
    configureContainerView()
    configureTitleLabel()
  }

  //MARK: - Methods
  func configureContainerView() {
    view.addSubview(containerView)
    containerView.backgroundColor = .systemBackground
    containerView.layer.cornerRadius = 16
    containerView.layer.borderWidth = 2
    containerView.layer.borderColor = UIColor.white.cgColor
    containerView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      containerView.heightAnchor.constraint(equalToConstant: 280),
      containerView.widthAnchor.constraint(equalToConstant: 220)
    ])
  }

  func configureTitleLabel() {
    containerView.addSubview(titleLabel)
    titleLabel.text = alertTitle ?? "No title"
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
      titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
      titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: - padding),
      titleLabel.heightAnchor.constraint(equalToConstant: 28)
    ])
  }
}
