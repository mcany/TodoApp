//
//  DatePickerTextField.swift
//  TodoApp
//
//  Created by Ugur Kilic on 11/04/2020.
//  Copyright © 2020 urklc. All rights reserved.
//

import UIKit

typealias DatePickerSetup = (minimum: Date, maximum: Date, current: Date)

final class DatePickerTextField: UITextField {

    /// Initial picker values
    var pickerSetup: DatePickerSetup? {
        didSet {
            datePicker.minimumDate = pickerSetup?.minimum
            datePicker.maximumDate = pickerSetup?.maximum
        }
    }

    /// Initial date for picker
    var initialDate: Date? {
        didSet {
            if let date = initialDate {
                datePicker.date = date
            }
        }
    }

    /// Current selected date
    var currentDate: Date? {
        guard let text = text, !text.isEmpty else {
            return nil
        }
        return dateFormatter.date(from: text)
    }

    private let datePicker = UIDatePicker(frame: .zero)

    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy HH:mm:ss"
        return formatter
    }()

    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    override func caretRect(for position: UITextPosition) -> CGRect {
        return CGRect.zero
    }

    private func setup() {
        addTarget(self, action: #selector(editingDidBegin), for: .editingDidBegin)

        addInputAccessoryView()

        datePicker.datePickerMode = .dateAndTime
        datePicker.addTarget(self,
                             action: #selector(datePickerValueChanged(_:)),
                             for: .valueChanged)
        inputView = datePicker
    }
}

// MARK: - Actions
@objc
private extension DatePickerTextField {

    func datePickerValueChanged(_ sender: UIDatePicker) {
        text = dateFormatter.string(from: sender.date)
        sendActions(for: .editingChanged)
    }

    func editingDidBegin() {
        guard let text = text, text.isEmpty else {
            return
        }
        datePicker.sendActions(for: .valueChanged)
    }

    func clearButtonTapped() {
        text = nil
        sendActions(for: .editingChanged)
        resignFirstResponder()
    }
}

private extension DatePickerTextField {

    func addInputAccessoryView() {
        let clearButton = UIBarButtonItem(
            title: "Clear",
            style: .done,
            target: self,
            action: #selector(clearButtonTapped))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let closeButton = UIBarButtonItem(
            title: "Done",
            style: .done,
            target: self,
            action: #selector(resignFirstResponder))
        let toolbar = UIToolbar(frame:
            CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40.0))
        toolbar.items = [clearButton, flexibleSpace, closeButton]
        inputAccessoryView = toolbar
    }
}
