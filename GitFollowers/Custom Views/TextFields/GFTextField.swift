//
//  GFTextField.swift
//  GitFollowers
//
//  Created by Николай Никитин on 15.07.2022.
//

import UIKit

class GFTextField: UITextField {
  
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
    translatesAutoresizingMaskIntoConstraints = false
    
    layer.cornerRadius = 10
    layer.borderWidth = 2
    layer.borderColor = UIColor.systemGray4.cgColor
    
    textColor = .label
    tintColor = .label
    textAlignment = .center
    font = UIFont.preferredFont(forTextStyle: .title2)
    adjustsFontSizeToFitWidth = true
    minimumFontSize = 12
    
    backgroundColor = .tertiarySystemBackground
    autocorrectionType = .no
    returnKeyType = .go
    clearButtonMode = .whileEditing 
    placeholder = "Enter a username..."
  }
}
