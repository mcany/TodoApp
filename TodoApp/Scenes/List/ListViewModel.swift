//
//  ListViewModel.swift
//  TodoApp
//
//  Created by Ugur Kilic on 5/09/2019.
//  Copyright © 2019 urklc. All rights reserved.
//

import Foundation

final class ListViewModel {

    /// Triggered when items are updated
    var itemsChanged: (() -> Void)? {
        didSet {
            refreshItems()
        }
    }

    private(set) var items: [Todo] = [] {
        didSet {
            itemsChanged?()
        }
    }

    private let database = CoreDataDatabase()

    func addItem(detail: String, reminder: Date?) {
        database.addItem(detail: detail, reminder: reminder)
        refreshItems()
    }

    func removeItem(at index: Int) {
        database.removeItem(todo: items[index])
        refreshItems()
    }

    func updateItem(at index: Int, status: Bool) {
        database.updateItem(todo: items[index], status: status)
        refreshItems()
    }
}

private extension ListViewModel {

    func refreshItems() {
        items = database.retrieveItems()
    }
}
