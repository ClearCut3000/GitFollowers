//
//  FollowerCell.swift
//  GitFollowers
//
//  Created by Николай Никитин on 19.07.2022.
//

import UIKit

class FollowerCell: UICollectionViewCell {

  //MARK: - Properties
  static let reuseID = "FollowerCell"

  //MARK: - Subview's
  let avatarImageView = GFAvatarImageView(frame: .zero)
  let usernameLabel = GFTitleLabel(textAlignment: .center, fontSize: 16)

  //MARK: - Init's
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  //MARK: - Methods
  func set(follower: Follower) {
    usernameLabel.text = follower.login
    avatarImageView.downloadImage(fromURL: follower.avatarUrl)
  }
  
  private func configure() {
    addSubviews(avatarImageView, usernameLabel)
    let padding: CGFloat = 8
    
    NSLayoutConstraint.activate([
      avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
      avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
      avatarImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
      avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),

      usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
      usernameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
      usernameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
      usernameLabel.heightAnchor.constraint(equalToConstant: 20)
    ])
  }
}
