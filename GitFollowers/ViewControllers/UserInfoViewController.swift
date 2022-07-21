//
//  UserInfoViewController.swift
//  GitFollowers
//
//  Created by Николай Никитин on 21.07.2022.
//

import UIKit

class UserInfoViewController: UIViewController {

  var username: String!

  override func viewDidLoad() {
    super.viewDidLoad()
    let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
    navigationItem.rightBarButtonItem = doneButton
  }

  @objc func dismissVC() {
    dismiss(animated: true, completion: nil)
  }
}
