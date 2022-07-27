//
//  GFDataLoadingViewController.swift
//  GitFollowers
//
//  Created by Николай Никитин on 28.07.2022.
//

import UIKit

class GFDataLoadingViewController: UIViewController {

  var containerView: UIView!

  func showLoadingView() {
    containerView = UIView(frame: view.bounds)
    view.addSubview(containerView)
    containerView.backgroundColor = .systemBackground
    containerView.alpha = 0
    UIView.animate(withDuration: 0.25) {
      self.containerView.alpha = 0.8
      let activityIndicator = UIActivityIndicatorView(style: .large)
      self.containerView.addSubview(activityIndicator)
      activityIndicator.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
      ])
      activityIndicator.startAnimating()
    }
  }

  func dismissLoadinView() {
    DispatchQueue.main.async {
      self.containerView.removeFromSuperview()
      self.containerView = nil
    }
  }

  func showEmptyStateView(with message: String, in view: UIView) {
    let emptyStateView = GFEmptyStateView(message: message)
    emptyStateView.frame = view.bounds
    view.addSubview(emptyStateView)
  }
}
