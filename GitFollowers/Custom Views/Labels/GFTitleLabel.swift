//
//  GFTitleLabel.swift
//  GitFollowers
//
//  Created by Николай Никитин on 17.07.2022.
//

import UIKit

class GFTitleLabel: UILabel {

  //MARK: - Init's
  override init(frame: CGRect) {
    super.init(frame: frame)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
    super.init(frame: .zero)
    self.textAlignment = textAlignment
    self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
    configure()
  }

  //MARK: - Methods
  private func configure() {
    textColor = .label
    adjustsFontSizeToFitWidth = true
    minimumScaleFactor = 0.9
    lineBreakMode = .byTruncatingTail
    translatesAutoresizingMaskIntoConstraints = false
  }

}
