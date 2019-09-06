//
//  DetailViewModel.swift
//  TodoApp
//
//  Created by Ugur Kilic on 6/09/2019.
//  Copyright © 2019 urklc. All rights reserved.
//

import Foundation

final class DetailViewModel {

    /// Minimum value for reminder date
    let minimumAllowedDate = Date().addingTimeInterval(120.0)

    weak var delegate: ItemEditingDelegate?

    /// Triggers delegate to add new item
    ///
    /// - Parameters:
    ///   - detail: Item detail
    ///   - reminder: Item reminder if exists
    func addTodoItem(detail: String, reminder: Date?) {
        delegate?.didCreateItem(detail: detail, reminder: reminder)
    }
}
