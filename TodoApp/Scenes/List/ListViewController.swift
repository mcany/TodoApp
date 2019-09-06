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

    @IBOutlet weak var todoTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        configureViews()

        viewModel.itemsChanged = { [weak self] in
            self?.todoTableView.reloadData()
        }
    }

    private func configureViews() {
        title = "My list"

        let addButton = UIBarButtonItem(barButtonSystemItem: .add,
                                        target: self,
                                        action: #selector(addTodoItem))
        navigationItem.rightBarButtonItem = addButton

        todoTableView.tableFooterView = UIView()
        todoTableView.uk_registerNibCell(ListTableViewCell.self)
    }

    @objc func addTodoItem() {
        guard let navigationController = navigationController else {
            return
        }
        router.proceedToItemAdding(current: navigationController, delegate: viewModel)
    }
}

// MARK: - UITableViewDataSource
extension ListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ListTableViewCell = tableView.uk_dequeueReusableCell(forIndexPath: indexPath)
        cell.delegate = self
        cell.configure(todo: viewModel.items[indexPath.row], index: indexPath.row)
        return cell
    }
}

// MARK: - ListTableViewCellDelegate
extension ListViewController: ListTableViewCellDelegate {

    func listTableViewCell(_ listTableViewCell: ListTableViewCell,
                           didUpdate status: Bool,
                           at index: Int) {
        viewModel.updateItem(at: index, status: status)
    }
}
