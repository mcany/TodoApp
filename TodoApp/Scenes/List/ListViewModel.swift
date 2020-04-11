//
//  ListViewModel.swift
//  TodoApp
//
//  Created by Ugur Kilic on 5/09/2019.
//  Copyright © 2019 urklc. All rights reserved.
//

import Foundation

final class ListViewModel {

    enum Change {

        case items
        case newItem
    }

    var stateChangeHandler: ((Change) -> Void)?

    private(set) var items: [Todo] = []

    private let database = CoreDataDatabase()

    func refreshItems(reload: Bool = true) {
        items = database.retrieveItems()
        stateChangeHandler?(reload ? .items: .newItem)
    }

    func updateItem(at index: Int, status: Bool) {
        database.updateItem(todo: items[index], status: status)
    }
}

// MARK: - ItemEditingDelegate
extension ListViewModel: ItemEditingDelegate {

    func didCreateItem(detail: String, reminder: Date?) {
        database.addItem(detail: detail, reminder: reminder)
        refreshItems(reload: true)
    }
}
