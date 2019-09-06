//
//  ListTableViewCell.swift
//  TodoApp
//
//  Created by Ugur Kilic on 5/09/2019.
//  Copyright © 2019 urklc. All rights reserved.
//

import UIKit

protocol ListTableViewCellDelegate: class {

    /// Called when cell updates status of the contained item
    ///
    /// - Parameters:
    ///   - listTableViewCell: List table view cell
    ///   - status: Updated status
    ///   - index: Item index
    func listTableViewCell(_ listTableViewCell: ListTableViewCell,
                           didUpdate status: Bool,
                           at index: Int)
}

final class ListTableViewCell: UITableViewCell {

    private enum Constant {

        static let defaultMargin: CGFloat = 15.0
    }

    weak var delegate: ListTableViewCellDelegate?

    private var index: Int?

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

    func configure(todo: Todo, index: Int) {
        self.index = index

        updateSelection(status: todo.status)
        detailLabel.text = todo.detail
        if let reminderDate = todo.reminder {
            reminderLabel.text = "Scheduled: \(DateUtility.string(from: reminderDate))"
        }
    }

    private func configureViews() {
        selectionStyle = .none

        statusButton = UIButton(type: .custom)
        statusButton.translatesAutoresizingMaskIntoConstraints = false
        statusButton.setImage(UIImage(named: "radio-off-button"), for: .normal)
        statusButton.setImage(UIImage(named: "radio-on-button"), for: .selected)
        statusButton.addTarget(self,
                               action: #selector(statusButtonValueChanged(_:)),
                               for: .touchUpInside)
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
            statusButton.widthAnchor.constraint(equalTo: statusButton.heightAnchor, multiplier: 1.0),
            statusButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            statusButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            statusButton.trailingAnchor.constraint(equalTo: detailLabel.leadingAnchor,
                                                   constant: -Constant.defaultMargin),
            detailLabel.topAnchor.constraint(equalTo: contentView.topAnchor,
                                             constant: Constant.defaultMargin),
            detailLabel.bottomAnchor.constraint(equalTo: reminderLabel.topAnchor),
            detailLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                constant: -Constant.defaultMargin),
            reminderLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                                  constant: -Constant.defaultMargin),
            reminderLabel.leadingAnchor.constraint(equalTo: detailLabel.leadingAnchor)
            ])

        statusButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        reminderLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }

    private func updateSelection(status: Bool) {
        statusButton.isSelected = status
        [detailLabel, reminderLabel].forEach { $0.textColor = status ? .lightGray : .black }
    }
}

// MARK: - Actions
private extension ListTableViewCell {

    @objc func statusButtonValueChanged(_ button: UIButton) {
        updateSelection(status: !button.isSelected)
        if let index = index {
            delegate?.listTableViewCell(self, didUpdate: button.isSelected, at: index)
        }
    }
}

// MARK: - Reusable
extension ListTableViewCell: Reusable { }
