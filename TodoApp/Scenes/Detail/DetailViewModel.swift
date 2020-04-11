//
//  DetailViewModel.swift
//  TodoApp
//
//  Created by Ugur Kilic on 6/09/2019.
//  Copyright © 2019 urklc. All rights reserved.
//

import Foundation

protocol ItemEditingDelegate: class {

    /// Called when item is ready to be created
    ///
    /// - Parameters:
    ///   - detail: Item detail
    ///   - reminder: Item reminder if exists
    func didCreateItem(detail: String, reminder: Date?)
}

final class DetailViewModel {

    /// Minimum value for reminder date
    let minimumAllowedDate = Date().addingTimeInterval(120.0)

    private weak var delegate: ItemEditingDelegate?

    init(delegate: ItemEditingDelegate) {
        self.delegate = delegate
    }

    /// Triggers delegate to add new item
    ///
    /// - Parameters:
    ///   - detail: Item detail
    ///   - reminder: Item reminder if exists
    func addTodoItem(detail: String, reminder: Date?) {
        delegate?.didCreateItem(detail: detail, reminder: reminder)
    }
}
