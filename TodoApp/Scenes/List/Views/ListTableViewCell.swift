//
//  ListTableViewCell.swift
//  TodoApp
//
//  Created by Ugur Kilic on 5/09/2019.
//  Copyright © 2019 urklc. All rights reserved.
//

import UIKit

final class ListTableViewCell: UITableViewCell {

    private enum Constant {

        static let defaultMargin: CGFloat = 15.0
    }

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

    func configure(todo: Todo) {
        statusButton.isSelected = todo.status
        detailLabel.text = todo.detail
        if let reminderDate = todo.reminder {
            reminderLabel.text = "Scheduled:\n\(DateUtility.string(from: reminderDate))"
        }
    }

    private func configureViews() {
        selectionStyle = .none

        statusButton = UIButton(type: .custom)
        statusButton.translatesAutoresizingMaskIntoConstraints = false
        statusButton.setImage(UIImage(named: "radio-off-button"), for: .normal)
        statusButton.setImage(UIImage(named: "radio-on-button"), for: .selected)
        contentView.addSubview(statusButton)

        detailLabel = UILabel()
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.numberOfLines = 0
        contentView.addSubview(detailLabel)

        reminderLabel = UILabel()
        reminderLabel.translatesAutoresizingMaskIntoConstraints = false
        reminderLabel.numberOfLines = 2
        reminderLabel.textAlignment = .center
        reminderLabel.font = UIFont.systemFont(ofSize: 10.0)
        contentView.addSubview(reminderLabel)

        NSLayoutConstraint.activate([
            statusButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            statusButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            statusButton.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor),
            contentView.bottomAnchor.constraint(greaterThanOrEqualTo: statusButton.topAnchor),
            detailLabel.topAnchor.constraint(equalTo: contentView.topAnchor,
                                             constant: Constant.defaultMargin),
            detailLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                                constant: -Constant.defaultMargin),
            statusButton.trailingAnchor.constraint(equalTo: detailLabel.leadingAnchor,
                                                   constant: -Constant.defaultMargin),
            reminderLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            reminderLabel.leadingAnchor.constraint(equalTo: detailLabel.trailingAnchor,
                                                   constant: Constant.defaultMargin),
            reminderLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                    constant: -Constant.defaultMargin),
            ])

        statusButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        reminderLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
}

extension ListTableViewCell: Reusable { }
