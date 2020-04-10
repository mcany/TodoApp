//
//  ListViewController.swift
//  TodoApp
//
//  Created by Ugur Kilic on 5/09/2019.
//  Copyright © 2019 urklc. All rights reserved.
//

import UIKit

final class ListViewController: UIViewController {

    private let viewModel = ListViewModel()
    private let router = ListRouter()

    @IBOutlet weak var todoCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        configureViews()
        viewModel.stateChangeHandler = { [weak self] change in
            self?.apply(change: change)
        }

        viewModel.refreshItems()
    }

    private func configureViews() {
        title = "My list"

        let addButton = UIBarButtonItem(barButtonSystemItem: .add,
                                        target: self,
                                        action: #selector(addTodoItem))
        navigationItem.rightBarButtonItem = addButton

        todoCollectionView.delegate = self
        todoCollectionView.dataSource = self
        todoCollectionView.uk_registerCell(ListCollectionViewCell.self)
    }

    private func apply(change: ListViewModel.Change) {
        switch change {
        case .items:
            todoCollectionView.reloadData()
        case .newItem:
            let indexPath = IndexPath(row: viewModel.items.count, section: 0)
            todoCollectionView.insertItems(at: [indexPath])
        }
    }

    @objc func addTodoItem() {
        guard let navigationController = navigationController else {
            return
        }
        router.proceedToItemAdding(current: navigationController, delegate: viewModel)
    }
}

// MARK: - UICollectionViewDataSource
extension ListViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.items.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ListCollectionViewCell = collectionView.uk_dequeueReusableCell(forIndexPath: indexPath)
        cell.configure(todo: viewModel.items[indexPath.row], index: indexPath.row, delegate: self)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ListViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 3
        return CGSize(width: width, height: width)
    }
}

// MARK: - ListCollectionViewCellDelegate
extension ListViewController: ListCollectionViewCellDelegate {

    func listCollectionViewCell(_ listCollectionViewCell: ListCollectionViewCell,
                                didUpdate status: Bool,
                                at index: Int) {
        viewModel.updateItem(at: index, status: status)
    }
}
