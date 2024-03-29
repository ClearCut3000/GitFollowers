//
//  String+Extension.swift
//  GitFollowers
//
//  Created by Николай Никитин on 24.07.2022.
//

import Foundation

#warning ("This extension is not used, but is left for reference purposes!")

extension String {
  
  func convertToDate() -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.timeZone = .current
    return dateFormatter.date(from: self)
  }
  
  func convertToDisplayFormat() -> String {
    guard let date = self.convertToDate() else { return "n/a"}
    return date.convertToMonthYearFormat()
  }
}
