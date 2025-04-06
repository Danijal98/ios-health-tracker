//
//  DateUtil.swift
//  iosHealthTracker
//
//  Created by Danijal Azerovic on 4/6/25.
//

import Foundation

extension Date {
    func toLocalString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy - HH:mm"
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        return formatter.string(from: self)
    }
}
