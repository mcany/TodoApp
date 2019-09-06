//
//  Database.swift
//  TodoApp
//
//  Created by Ugur Kilic on 5/09/2019.
//  Copyright © 2019 urklc. All rights reserved.
//

import Foundation

protocol Database {

    /// Adds todo item with given details
    ///
    /// - Parameters:
    ///   - detail: Todo detailed description
    ///   - reminder: Reminder if exists
    func addItem(detail: String, reminder: Date?)

    /// Update todo item status
    ///
    /// - Parameter todo: Todo item
    func updateItem(todo: Todo, status: Bool)

    /// Retrieves todo items from database
    ///
    /// - Returns: Todo item list
    func retrieveItems() -> [Todo]
}
