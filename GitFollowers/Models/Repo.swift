//
//  Repo.swift
//  GitFollowers
//
//  Created by Николай Никитин on 02.08.2022.
//

import Foundation

struct Repo: Codable {
  let name: String
  var description: String?
  let htmlUrl: String
  let stargazersCount: Int
  let forksCount: Int
}
