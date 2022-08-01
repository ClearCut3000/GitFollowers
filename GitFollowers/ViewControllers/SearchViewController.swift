//
//  SearchViewController.swift
//  GitFollowers
//
//  Created by Николай Никитин on 14.07.2022.
//

import UIKit

class SearchViewController: UIViewController {

  //MARK: - Properties
  var isUsernameEntered: Bool { return !userNameTextField.text!.isEmpty }

  //MARK: - Subview's
  let logoImageView = UIImageView()
  let userNameTextField = GFTextField()
  let callToAtionButton = GFButton(backgroundColor: .systemGreen, title: "Get Followers")

  //MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    view.addSubviews(logoImageView, userNameTextField, callToAtionButton)
    configureLogoViewView()
    configureTextField()
    configureCallToActionButton()
    createDismissKeyboardTapGesture()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    userNameTextField.text = ""
    navigationController?.setNavigationBarHidden(true, animated: true)
  }

  //MARK: - Methods
  @objc func pushFolloverListViewController() {
    guard isUsernameEntered else {
      presentGFAlertOnMailThread(title: "Empty Username!", message: "Please enter a username. We need to know who to look for.", buttonTitle: "OK")
      return
    }
    userNameTextField.resignFirstResponder()
    let followerListVC = FollowerListViewController(username: userNameTextField.text!)
    navigationController?.pushViewController(followerListVC, animated: true)
  }

  func configureLogoViewView() {
    logoImageView.translatesAutoresizingMaskIntoConstraints = false
    logoImageView.image = Images.ghLogo

    let topConnstrainConstant: CGFloat = DeviceType.isiPhoneSE || DeviceType.isiPhone8Zoomed ? 20 : 80

    NSLayoutConstraint.activate([
      logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConnstrainConstant),
      logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      logoImageView.heightAnchor.constraint(equalToConstant: 200),
      logoImageView.widthAnchor.constraint(equalToConstant: 200)
    ])
  }

  func configureTextField() {
    userNameTextField.delegate = self
    NSLayoutConstraint.activate([
      userNameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
      userNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
      userNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
      userNameTextField.heightAnchor.constraint(equalToConstant: 50)
    ])
  }

  func configureCallToActionButton() {
    callToAtionButton.addTarget(self, action: #selector(pushFolloverListViewController), for: .touchUpInside)
    NSLayoutConstraint.activate([
      callToAtionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
      callToAtionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
      callToAtionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
      callToAtionButton.heightAnchor.constraint(equalToConstant: 50)
    ])
  }
  
  func createDismissKeyboardTapGesture() {
    let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
    view.addGestureRecognizer(tap)
  }
}

//MARK: - TextFieldDelegate Protocol Extension
extension SearchViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    pushFolloverListViewController()
    return true
  }
}
