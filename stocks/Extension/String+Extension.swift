//
//  String+Extension.swift
//  stocks
//
//  Created by Sandesh Naik on 02/02/25.
//

import Foundation

extension String {
    func toDate(format: String = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = .current
        return dateFormatter.date(from: self)
    }
}

