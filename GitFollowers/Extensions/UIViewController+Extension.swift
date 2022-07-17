//
//  UIViewController+Extension.swift
//  GitFollowers
//
//  Created by Николай Никитин on 18.07.2022.
//

import UIKit

extension UIViewController {

  func presentGFAlertOnMailThread(title: String, message: String, buttonTitle: String) {
    DispatchQueue.main.async {
      let alertVC = GFAlertViewController(title: title, message: message, buttonTitle: buttonTitle)
      alertVC.modalPresentationStyle = .overFullScreen
      alertVC.modalTransitionStyle = .crossDissolve
      self.present(alertVC, animated: true)
    }
  }

}
