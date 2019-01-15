//
//  DateFormatter.swift
//  Core-Data-Journal
//
//  Created by Madison Waters on 1/15/19.
//  Copyright © 2019 Jonah Bergevin. All rights reserved.
//

import Foundation

extension Date {
    var formatter: DateFormatter? {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        formatter.doesRelativeDateFormatting = true
        return formatter
    }
}
