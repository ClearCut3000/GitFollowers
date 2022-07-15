//
//  SearchViewController.swift
//  GitFollowers
//
//  Created by Николай Никитин on 14.07.2022.
//

import UIKit

class SearchViewController: UIViewController {

  //MARK: - Subview's
  let logoImageView = UIImageView()
  let userNameTextFielf = GFTextField()
  let callToAtionButton = GFButton(backgroundColor: .systemGreen, title: "Get Followers")

  //MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    configureLogoViewView()
    configureTextField()
    configureCallToActionButton()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.isNavigationBarHidden = true
  }

  //MARK: - Methods
  func configureLogoViewView() {
    view.addSubview(logoImageView)
    logoImageView.translatesAutoresizingMaskIntoConstraints = false
    logoImageView.image = UIImage(named: "gh-logo")
    NSLayoutConstraint.activate([
      logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
      logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      logoImageView.heightAnchor.constraint(equalToConstant: 200),
      logoImageView.widthAnchor.constraint(equalToConstant: 200)
    ])
  }

  func configureTextField() {
    view.addSubview(userNameTextFielf)
    NSLayoutConstraint.activate([
      userNameTextFielf.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
      userNameTextFielf.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
      userNameTextFielf.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
      userNameTextFielf.heightAnchor.constraint(equalToConstant: 50)
    ])
  }

  func configureCallToActionButton() {
    view.addSubview(callToAtionButton)
    NSLayoutConstraint.activate([
      callToAtionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
      callToAtionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
      callToAtionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
      callToAtionButton.heightAnchor.constraint(equalToConstant: 50)
    ])
  }

}
