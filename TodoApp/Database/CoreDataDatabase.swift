//
//  CoreDataDatabase.swift
//  TodoApp
//
//  Created by Ugur Kilic on 5/09/2019.
//  Copyright © 2019 urklc. All rights reserved.
//

import CoreData
import Foundation

final class CoreDataDatabase {

    private let container: NSPersistentContainer

    private var context: NSManagedObjectContext {
        return container.viewContext
    }

    init() {
        container = NSPersistentContainer(name: "TodoApp")
        container.loadPersistentStores { (_, _) in }
    }
}

extension CoreDataDatabase: Database {

    func addItem(detail: String, reminder: Date?) {
        context.perform { [weak self] in
            guard let strongSelf = self else {
                return
            }
            let item = Todo(context: strongSelf.context)
            item.detail = detail
            item.reminder = reminder
            item.created = Date()
            strongSelf.save()
        }
    }

    func removeItem(todo: Todo) {
        context.perform { [weak self] in
            guard let strongSelf = self else {
                return
            }

            strongSelf.context.delete(todo)
            strongSelf.save()
        }
    }

    func updateItem(todo: Todo, status: Bool) {
        context.perform { [weak self] in
            guard let strongSelf = self else {
                return
            }

            todo.status = status
            strongSelf.save()
        }
    }

    func retrieveItems() -> [Todo] {
        var items: [Todo]?
        context.performAndWait { [weak self] in
            guard let strongSelf = self else {
                return
            }

            items = try? strongSelf.context.fetch(Todo.fetchRequest()) as? [Todo]
        }
        return items ?? []
    }
}

private extension CoreDataDatabase {

    func save() {
        context.perform { [weak self] in
            guard let strongSelf = self else {
                return
            }
            if strongSelf.context.hasChanges {
                try? strongSelf.context.save()
            }
        }
    }
}
