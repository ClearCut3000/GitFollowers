//
//  RepoCell.swift
//  GitFollowers
//
//  Created by Николай Никитин on 03.08.2022.
//

import UIKit

class RepoCell: UICollectionViewCell {

  //MARK: - Properties
  static let reuseID = "RepoCell"

  //MARK: - Subview's
  let nameLabel = GFTitleLabel(textAlignment: .left, fontSize: 16)
  let descriptionLabel = GFSecondaryTitleLabel(fontSize: 14)
  let starsCountLabel = GFTitleLabel(textAlignment: .center, fontSize: 16)
  let forksCountLabel = GFTitleLabel(textAlignment: .center, fontSize: 16)
  let starImageView = UIImageView()
  let forksImageView = UIImageView()

  //MARK: - Init's
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  //MARK: - Methods
  func set(repo: Repo) {
    nameLabel.text = repo.name
    descriptionLabel.text = repo.description ?? "No description for thise repository!"
    starsCountLabel.text = "\(repo.stargazersCount)"
    forksCountLabel.text = "\(repo.forksCount)"
  }

  private func configure() {
    configureUIElements()

    addSubviews(nameLabel, descriptionLabel, starsCountLabel, forksCountLabel, forksImageView, starImageView)
    let padding: CGFloat = 8

    NSLayoutConstraint.activate([
      nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
      nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
      nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
      nameLabel.heightAnchor.constraint(equalToConstant: 20),

      descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: padding),
      descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
      descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
      descriptionLabel.heightAnchor.constraint(equalToConstant: 35),

      starImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
      starImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
      starImageView.heightAnchor.constraint(equalToConstant: 20),
      starImageView.widthAnchor.constraint(equalToConstant: 20),

      starsCountLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
      starsCountLabel.leadingAnchor.constraint(equalTo: starImageView.trailingAnchor, constant: padding),
      starsCountLabel.heightAnchor.constraint(equalToConstant: 20),
      starsCountLabel.widthAnchor.constraint(equalToConstant: 40),

      forksImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
      forksImageView.leadingAnchor.constraint(equalTo: centerXAnchor),
      forksImageView.heightAnchor.constraint(equalToConstant: 20),
      forksImageView.widthAnchor.constraint(equalToConstant: 20),

      forksCountLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
      forksCountLabel.leadingAnchor.constraint(equalTo: forksImageView.trailingAnchor, constant: -padding),
      forksCountLabel.heightAnchor.constraint(equalToConstant: 20),
      forksCountLabel.widthAnchor.constraint(equalToConstant: 60),
    ])
  }

  private func configureUIElements() {
    contentView.backgroundColor = .tertiarySystemBackground
    contentView.layer.cornerRadius = 10
    contentView.layer.borderWidth = 2
    contentView.layer.borderColor = UIColor.secondarySystemBackground.cgColor

    starImageView.image = SFSymbols.stars
    starImageView.translatesAutoresizingMaskIntoConstraints = false
    starImageView.contentMode = .scaleAspectFit
    starImageView.tintColor = .label

    forksImageView.image = SFSymbols.forks
    forksImageView.translatesAutoresizingMaskIntoConstraints = false
    forksImageView.contentMode = .scaleAspectFit
    forksImageView.tintColor = .label

    descriptionLabel.numberOfLines = 2
  }
}

