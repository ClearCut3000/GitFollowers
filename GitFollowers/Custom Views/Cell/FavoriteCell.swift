//
//  FavoriteCell.swift
//  GitFollowers
//
//  Created by Николай Никитин on 25.07.2022.
//

import UIKit

class FavoriteCell: UITableViewCell {

  //MARK: - Properties
  static let reuseID = "FavoriteCell"

  //MARK: - Subviews
  let avatarImageView = GFAvatarImageView(frame: .zero)
  let usernameLabel = GFTitleLabel(textAlignment: .left, fontSize: 26)

  //MARK: - Init's
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    configure()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  //MARK: - Methods
  func set(favorite: Follower) {
    avatarImageView.downloadImage(fromURL: favorite.avatarUrl)
    usernameLabel.text = favorite.login
  }
  
  private func configure() {
    addSubviews(avatarImageView, usernameLabel)
    accessoryType = .disclosureIndicator
    let padding: CGFloat = 12
    NSLayoutConstraint.activate([
      avatarImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
      avatarImageView.heightAnchor.constraint(equalToConstant: 60),
      avatarImageView.widthAnchor.constraint(equalToConstant: 60),

      usernameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 24),
      usernameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
      usernameLabel.heightAnchor.constraint(equalToConstant: 40)
    ])
  }
}
