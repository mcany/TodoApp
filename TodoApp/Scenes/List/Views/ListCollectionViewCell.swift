//
//  ListCollectionViewCell.swift
//  TodoApp
//
//  Created by Ugur Kilic on 5/09/2019.
//  Copyright © 2019 urklc. All rights reserved.
//

import UIKit

protocol ListCollectionViewCellDelegate: class {

    /// Called when cell updates status of the contained item
    ///
    /// - Parameters:
    ///   - listCollectionViewCell: List collection view cell
    ///   - status: Updated status
    ///   - index: Item index
    func listCollectionViewCell(_ listCollectionViewCell: ListCollectionViewCell,
                                didUpdate status: Bool,
                                at index: Int)
}

final class ListCollectionViewCell: UICollectionViewCell {

    private enum Constant {

        static let margin: CGFloat = 2.0
    }

    weak var delegate: ListCollectionViewCellDelegate?

    private var index: Int = 0 {
        didSet {
            shadowView.backgroundColor = index % 2 == 0 ? .systemGray4 : .systemGray2
        }
    }

    private var shadowView: UIView!
    private var statusButton: UIButton!
    private var detailLabel: UILabel!
    private var reminderLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureViews()
    }

    func configure(todo: Todo, index: Int, delegate: ListCollectionViewCellDelegate?) {
        self.index = index
        self.delegate = delegate

        updateSelection(status: todo.status)
        detailLabel.text = todo.detail
        if let reminderDate = todo.reminder {
            reminderLabel.text = DateUtility.string(from: reminderDate)
        }
    }

    private func configureViews() {
        shadowView = UIView()
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        shadowView.layer.uk_applyShadow()
        contentView.addSubview(shadowView)

        statusButton = UIButton(type: .custom)
        statusButton.translatesAutoresizingMaskIntoConstraints = false
        statusButton.setImage(UIImage(named: "radio-off-button"), for: .normal)
        statusButton.setImage(UIImage(named: "radio-on-button"), for: .selected)
        statusButton.addTarget(self,
                               action: #selector(statusButtonValueChanged(_:)),
                               for: .touchUpInside)
        shadowView.addSubview(statusButton)

        detailLabel = UILabel()
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.numberOfLines = 0
        detailLabel.textAlignment = .center
        detailLabel.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        shadowView.addSubview(detailLabel)

        reminderLabel = UILabel()
        reminderLabel.translatesAutoresizingMaskIntoConstraints = false
        reminderLabel.numberOfLines = 2
        reminderLabel.textAlignment = .center
        reminderLabel.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
        shadowView.addSubview(reminderLabel)

        NSLayoutConstraint.activate([
            shadowView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constant.margin),
            shadowView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constant.margin),
            shadowView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constant.margin),
            shadowView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constant.margin),
            statusButton.widthAnchor.constraint(equalTo: statusButton.heightAnchor, multiplier: 1.0),
            statusButton.topAnchor.constraint(equalTo: shadowView.topAnchor, constant: Constant.margin),
            statusButton.centerXAnchor.constraint(equalTo: shadowView.centerXAnchor),
            detailLabel.topAnchor.constraint(equalTo: statusButton.bottomAnchor, constant: Constant.margin),
            detailLabel.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor),
            detailLabel.trailingAnchor.constraint(equalTo: shadowView.trailingAnchor),
            reminderLabel.topAnchor.constraint(greaterThanOrEqualTo: detailLabel.bottomAnchor),
            reminderLabel.centerXAnchor.constraint(equalTo: shadowView.centerXAnchor),
            reminderLabel.bottomAnchor.constraint(equalTo: shadowView.bottomAnchor)
            ])

        statusButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        reminderLabel.setContentCompressionResistancePriority(.required, for: .vertical)
    }

    private func updateSelection(status: Bool) {
        statusButton.isSelected = status
        [detailLabel, reminderLabel].forEach { $0.textColor = status ? .systemGray : .black }
    }
}

// MARK: - Actions
private extension ListCollectionViewCell {

    @objc func statusButtonValueChanged(_ button: UIButton) {
        updateSelection(status: !button.isSelected)
        delegate?.listCollectionViewCell(self, didUpdate: button.isSelected, at: index)
    }
}

// MARK: - Reusable
extension ListCollectionViewCell: Reusable { }
