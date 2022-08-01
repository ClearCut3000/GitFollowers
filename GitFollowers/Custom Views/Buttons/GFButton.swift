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
  
  convenience init(backgroundColor: UIColor, title: String) {
    self.init(frame: .zero)
    self.backgroundColor = backgroundColor
    self.setTitle(title, for: .normal)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - Methods
  func set(backgroundColor: UIColor, title: String) {
    self.backgroundColor = backgroundColor
    setTitle(title, for: .normal)
  }
  
  private func configure() {
    layer.cornerRadius = 10
    setTitleColor(.white, for: .normal)
    titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
    translatesAutoresizingMaskIntoConstraints = false
  }
}
