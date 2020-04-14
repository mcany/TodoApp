//
//  ListRouter.swift
//  TodoApp
//
//  Created by Ugur Kilic on 6/09/2019.
//  Copyright © 2019 urklc. All rights reserved.
//

import UIKit

final class ListRouter: GenericRouting {

    func proceedToItemAdding(current: UINavigationController, delegate: ItemEditingDelegate) {
        let controller = DetailViewController()
        controller.viewModel = DetailViewModel(delegate: delegate)
        controller.router = self

        let navigationController = UINavigationController(rootViewController: controller)
        navigationController.modalPresentationStyle = .overFullScreen
        current.present(navigationController, animated: true, completion: nil)
    }
}
