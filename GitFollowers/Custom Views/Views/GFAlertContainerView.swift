//
//  GFAlertContainerView.swift
//  GitFollowers
//
//  Created by Николай Никитин on 27.07.2022.
//

import UIKit

class GFAlertContainerView: UIView {
  
  //MARK: - Init's
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - Methods
  private func configure() {
    backgroundColor = .systemBackground
    layer.cornerRadius = 16
    layer.borderWidth = 2
    layer.borderColor = UIColor.white.cgColor
    translatesAutoresizingMaskIntoConstraints = false
  }
}
