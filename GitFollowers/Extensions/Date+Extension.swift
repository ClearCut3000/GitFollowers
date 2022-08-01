//
//  Date+Extension.swift
//  GitFollowers
//
//  Created by Николай Никитин on 24.07.2022.
//

import Foundation

extension Date {
  
  func convertToMonthYearFormat() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMM yyyy"
    return formatter.string(from: self)
  }
}
