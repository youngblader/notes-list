//
//  DateFormatter.swift
//  NoteX
//
//  Created by Евгений Зорич on 23.02.24.
//

import Foundation

extension Date {
    static func dateFromString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = .medium
        dateFormatter.locale = Locale(identifier: "en_US")
        
        return dateFormatter.string(from: date)
    }
}
