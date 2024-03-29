//
//  Constants.swift
//  GitFollowers
//
//  Created by Николай Никитин on 22.07.2022.
//

import UIKit

enum SFSymbols {
  static let location = UIImage(systemName: "mappin.and.ellipse")
  static let repos = UIImage(systemName: "folder")
  static let gists = UIImage(systemName: "text.alignment")
  static let followers = UIImage(systemName: "heart")
  static let following = UIImage(systemName:"person.2")
  static let stars = UIImage(systemName: "star.fill")
  static let forks = UIImage(systemName: "shuffle")
  static let repo = UIImage(systemName: "server.rack")
}

enum Images {
  static let ghLogo = UIImage(named: "gh-logo")
  static let  placeholder = UIImage(named: "avatar-placeholder")
  static let emptyStateLogo = UIImage(named: "empty-state-logo")
}

enum ScreenSize {
  static let width = UIScreen.main.bounds.size.width
  static let height = UIScreen.main.bounds.size.height
  static let maxLenght = max(ScreenSize.width, ScreenSize.height)
  static let minLenght = min(ScreenSize.width, ScreenSize.height)
}

enum DeviceType {
  static let idiom = UIDevice.current.userInterfaceIdiom
  static let nativeScale = UIScreen.main.nativeScale
  static let scale = UIScreen.main.scale

  static let isiPhoneSE = idiom == .phone && ScreenSize.maxLenght == 568.0
  static let isiPhone8Standart = idiom == .phone && ScreenSize.maxLenght == 667.0 && nativeScale == scale
  static let isiPhone8Zoomed = idiom == .phone && ScreenSize.maxLenght == 667.0 && nativeScale > scale
  static let isiPhone8PlusStandart = idiom == .phone && ScreenSize.maxLenght == 736.0
  static let isiPhone8PlusZoomed = idiom == .phone && ScreenSize.maxLenght == 736.0 && nativeScale < scale
  static let isiPhoneX = idiom == .phone && ScreenSize.maxLenght == 812.0
  static let isiPhoneXSMaxAndXR = idiom == .phone && ScreenSize.maxLenght == 896.0
  static let isiPad = idiom == .phone && ScreenSize.maxLenght >= 1024.0

  static func isiPhoneXAspectRatio() -> Bool {
    return isiPhoneX || isiPhoneXSMaxAndXR
  }
}
