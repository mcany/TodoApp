//
//  GenericRouting.swift
//  TodoApp
//
//  Created by Ugur Kilic on 6/09/2019.
//  Copyright © 2019 urklc. All rights reserved.
//

import UIKit

protocol GenericRouting {

    func dismiss(current: UIViewController)
}

extension GenericRouting {

    func dismiss(current: UIViewController) {
        current.dismiss(animated: true, completion: nil)
    }
}
