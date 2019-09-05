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

    @IBOutlet weak var todoTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        configureViews()

        viewModel.itemsChanged = { [weak self] in
            self?.todoTableView.reloadData()
        }
    }

    private func configureViews() {
        todoTableView.uk_registerNibCell(ListTableViewCell.self)
    }
}

// MARK: - UITableViewDataSource
extension ListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ListTableViewCell = tableView.uk_dequeueReusableCell(forIndexPath: indexPath)
        cell.configure(todo: viewModel.items[indexPath.row])
        return cell
    }
}
