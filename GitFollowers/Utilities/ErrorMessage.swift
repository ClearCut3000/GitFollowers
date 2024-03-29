//
//  ErrorMessage.swift
//  GitFollowers
//
//  Created by Николай Никитин on 18.07.2022.
//

import Foundation

enum GFError: String, Error {
  case invalidUsername = "This username created invalid request. Please try again."
  case unableToComplete = "Unable to complete your request. Please check your internet connection"
  case invalidResponse = "Invalid response from the server. Please try again."
  case invalidData = "The data received from the server was invalid. Please try again."
  case unableToFavorites = "There was an error favoriting this user. Please try again."
  case alreadyInFavorites = "You already favorited this user."
}
