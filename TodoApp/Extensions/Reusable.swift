//
//  Reusable.swift
//  TodoApp
//
//  Created by Ugur Kilic on 5/09/2019.
//  Copyright © 2019 urklc. All rights reserved.
//

import Foundation

public protocol Reusable: class {
    static var defaultReuseIdentifier: String { get }
}

public extension Reusable where Self: NSObject {

    static var defaultReuseIdentifier: String {
        return NSStringFromClass(self)
    }
}
