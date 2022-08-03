//
//  UsernameManager.swift
//  GitFollowers
//
//  Created by Николай Никитин on 03.08.2022.
//

import Foundation

class Username {
  static let shared = Username()
  var username: String = ""
  private init() {}
}
