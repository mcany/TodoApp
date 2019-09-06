//
//  ListViewModel.swift
//  TodoApp
//
//  Created by Ugur Kilic on 5/09/2019.
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

    func updateItem(at index: Int, status: Bool) {
        database.updateItem(todo: items[index], status: status)
    }
}

// MARK: - ItemEditingDelegate
extension ListViewModel: ItemEditingDelegate {

    func didCreateItem(detail: String, reminder: Date?) {
        database.addItem(detail: detail, reminder: reminder)
        refreshItems()
    }
}

// MARK: - Helpers
private extension ListViewModel {

    func refreshItems() {
        items = database.retrieveItems()
    }
}
