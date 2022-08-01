//
//  GFItemInfoView.swift
//  GitFollowers
//
//  Created by Николай Никитин on 23.07.2022.
//

import UIKit

enum ItemInfoType {
  case gists, followers, following, repos
}

class GFItemInfoView: UIView {

  //MARK: - Subviews
  let symbolImageView = UIImageView()
  let titleLabel = GFTitleLabel(textAlignment: .left, fontSize: 14)
  let countLabel = GFTitleLabel(textAlignment: .center, fontSize: 14)

  //MARK: - Init's
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func configure() {
    addSubviews(symbolImageView, titleLabel, countLabel)

    symbolImageView.translatesAutoresizingMaskIntoConstraints = false
    symbolImageView.contentMode = .scaleAspectFit
    symbolImageView.tintColor = .label

    NSLayoutConstraint.activate([
      symbolImageView.topAnchor.constraint(equalTo: self.topAnchor),
      symbolImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      symbolImageView.widthAnchor.constraint(equalToConstant: 20),
      symbolImageView.heightAnchor.constraint(equalToConstant: 20),

      titleLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
      titleLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 12),
      titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      titleLabel.heightAnchor.constraint(equalToConstant: 18),

      countLabel.topAnchor.constraint(equalTo: symbolImageView.bottomAnchor, constant: 4),
      countLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      countLabel.heightAnchor.constraint(equalToConstant: 18)
    ])
  }

  //MARK: - Methods
  func set(itemInfoType: ItemInfoType, withCount count: Int) {
    switch itemInfoType {
    case .gists:
      symbolImageView.image = SFSymbols.gists
      titleLabel.text = "Public Gists"
    case .followers:
      symbolImageView.image = SFSymbols.followers
      titleLabel.text = "Followers"
    case .following:
      symbolImageView.image = SFSymbols.following
      titleLabel.text = "Followings"
    case .repos:
      symbolImageView.image = SFSymbols.repos
      titleLabel.text = "Public Repos"
    }
    countLabel.text = String(count)
  }
}
