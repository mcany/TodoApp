//
//  CoreDataDatabase.swift
//  TodoApp
//
//  Created by Ugur Kilic on 5/09/2019.
//  Copyright © 2019 urklc. All rights reserved.
//

import CoreData
import Foundation
import UIKit

final class CoreDataDatabase {

    private let container: NSPersistentContainer

    private var context: NSManagedObjectContext {
        return container.viewContext
    }

    init() {
        container = NSPersistentContainer(name: "TodoApp")
        container.loadPersistentStores { (_, _) in }

        addApplicationObservers()
    }

    private func addApplicationObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(save),
                                               name: UIApplication.willTerminateNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(save),
                                               name: UIApplication.willResignActiveNotification,
                                               object: nil)
    }
}

extension CoreDataDatabase: Database {

    func addItem(detail: String, reminder: Date?) {
        context.performAndWait { [weak self] in
            guard let strongSelf = self else {
                return
            }
            let item = Todo(context: strongSelf.context)
            item.detail = detail
            item.reminder = reminder
            item.created = Date()
        }
    }

    func updateItem(todo: Todo, status: Bool) {
        context.perform {
            todo.status = status
        }
    }

    func retrieveItems() -> [Todo] {
        save()

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

    @objc func save() {
        context.performAndWait { [weak self] in
            guard let strongSelf = self else {
                return
            }
            if strongSelf.context.hasChanges {
                try? strongSelf.context.save()
            }
        }
    }
}
