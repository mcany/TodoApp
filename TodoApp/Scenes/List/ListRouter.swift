//
//  ListRouter.swift
//  TodoApp
//
//  Created by Ugur Kilic on 6/09/2019.
//  Copyright © 2019 urklc. All rights reserved.
//

import UIKit

final class ListRouter: GenericRouting {

    private let transitionManager = TransitionManager()

    func proceedToItemAdding(current: UINavigationController, delegate: ItemEditingDelegate) {
        let controller = DetailViewController()
        controller.viewModel = DetailViewModel()
        controller.viewModel.delegate = delegate
        controller.router = self

        controller.transitioningDelegate = transitionManager
        controller.modalPresentationStyle = .custom
        current.present(controller, animated: true, completion: nil)
    }
}
