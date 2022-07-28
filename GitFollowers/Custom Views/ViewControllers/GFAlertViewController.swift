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
  let containerView = GFAlertContainerView()
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
    view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
    view.addSubviews(containerView, titleLabel, messageLabel, actionButton)
    configureContainerView()
    configureTitleLabel()
    configureActionButton()
    configureMessageLabel()
  }

  //MARK: - Methods
  func configureContainerView() {
    NSLayoutConstraint.activate([
      containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      containerView.heightAnchor.constraint(equalToConstant: 280),
      containerView.widthAnchor.constraint(equalToConstant: 220)
    ])
  }

  func configureTitleLabel() {
    titleLabel.text = alertTitle ?? "No title"
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
      titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
      titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
      titleLabel.heightAnchor.constraint(equalToConstant: 28)
    ])
  }

  func configureActionButton() {
    actionButton.setTitle(buttonTitle ?? "OK", for: .normal)
    actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
    NSLayoutConstraint.activate([
      actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
      actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
      actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
      actionButton.heightAnchor.constraint(equalToConstant: 44)
    ])
  }

  func configureMessageLabel() {
    messageLabel.text = message ?? "Unable to complete request!"
    messageLabel.numberOfLines = 4
    NSLayoutConstraint.activate([
      messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
      messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
      messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
      messageLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -12)
    ])
  }

  @objc func dismissVC() {
    dismiss(animated: true, completion: nil)
  }
}
