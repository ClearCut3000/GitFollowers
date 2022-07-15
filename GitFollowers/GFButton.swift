//
//  GFButton.swift
//  GitFollowers
//
//  Created by Николай Никитин on 14.07.2022.
//

import UIKit

class GFButton: UIButton {

  //MARK: - Init's
  override init(frame: CGRect) {
    super.init(frame: frame)
    //custom configuration
    configure()
  }

  init(backgroundColor: UIColor, title: String) {
    super.init(frame: .zero)
    self.backgroundColor = backgroundColor
    self.setTitle(title, for: .normal)
    configure()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  //MARK: - Methods
  private func configure() {
    layer.cornerRadius = 10
    titleLabel?.textColor = .white
    titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
    translatesAutoresizingMaskIntoConstraints = false
  }
}
