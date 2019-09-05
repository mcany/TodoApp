//
//  DateUtility.swift
//  TodoApp
//
//  Created by Ugur Kilic on 5/09/2019.
//  Copyright © 2019 urklc. All rights reserved.
//

import Foundation

final class DateUtility {

    static var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy hh:mm"
        return formatter
    }()

    static func string(from date: Date) -> String {
        return DateUtility.formatter.string(from: date)
    }
}
