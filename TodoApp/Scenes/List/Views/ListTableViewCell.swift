//
//  ListTableViewCell.swift
//  TodoApp
//
//  Created by Ugur Kilic on 5/09/2019.
//  Copyright © 2019 urklc. All rights reserved.
//

import UIKit

final class ListTableViewCell: UITableViewCell {

    private var statusButton: UIButton!
    private var detailLabel: UILabel!
    private var reminderLabel: UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        configureViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureViews() {
        // TODO: configure views
    }
}

extension ListTableViewCell: Reusable { }
