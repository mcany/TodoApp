//
//  UITableView+Additions.swift
//  TodoApp
//
//  Created by Ugur Kilic on 5/09/2019.
//  Copyright © 2019 urklc. All rights reserved.
//

import UIKit

public extension UITableView {

    func uk_registerNibCell<T: UITableViewCell & Reusable>(_: T.Type) {
        register(T.self, forCellReuseIdentifier: T.defaultReuseIdentifier)
    }

    func uk_dequeueReusableCell<T: Reusable>(forIndexPath indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier) as! T
    }
}
