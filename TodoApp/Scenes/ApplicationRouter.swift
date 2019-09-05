//
//  ApplicationRouter.swift
//  TodoApp
//
//  Created by Ugur Kilic on 5/09/2019.
//  Copyright © 2019 urklc. All rights reserved.
//

import UIKit

final class ApplicationRouter {

    private var window: UIWindow!

    func initialize() {
        window = UIWindow(frame: UIScreen.main.bounds)

        let controller = ListViewController()
        let navigationController = UINavigationController(rootViewController: controller)
        window.rootViewController = navigationController

        window.makeKeyAndVisible()
    }
}
