//
//  UIViewController+Extension.swift
//  GitFollowers
//
//  Created by Николай Никитин on 18.07.2022.
//

import UIKit
import SafariServices

extension UIViewController {
  
  /// Presents Alert ViewControllers derectly on main thread
  func presentGFAlertOnMailThread(title: String, message: String, buttonTitle: String) {
    DispatchQueue.main.async {
      let alertVC = GFAlertViewController(title: title, message: message, buttonTitle: buttonTitle)
      alertVC.modalPresentationStyle = .overFullScreen
      alertVC.modalTransitionStyle = .crossDissolve
      self.present(alertVC, animated: true)
    }
  }
  
  /// Presents safaru view controller 
  func presentSafariVC(with url: URL) {
    let safariVC = SFSafariViewController(url: url)
    safariVC.preferredControlTintColor = .systemGreen
    present(safariVC, animated: true)
  }
}
