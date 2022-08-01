//
//  GFAvatarImageView.swift
//  GitFollowers
//
//  Created by Николай Никитин on 19.07.2022.
//

import UIKit

class GFAvatarImageView: UIImageView {

  let cache = NetworkManager.shared.cache
  let placeholderImage = Images.placeholder

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
    layer.cornerRadius = 10
    clipsToBounds = true
    image = placeholderImage
    translatesAutoresizingMaskIntoConstraints = false
  }

  func downloadImage(fromURL url: String) {
    NetworkManager.shared.downloadImage(from: url) { [weak self] image in
      guard let self = self else { return }
      DispatchQueue.main.async { self.image = image }
    }
  }
}
