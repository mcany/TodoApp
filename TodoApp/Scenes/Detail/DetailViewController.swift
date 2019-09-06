//
//  DetailViewController.swift
//  TodoApp
//
//  Created by Ugur Kilic on 6/09/2019.
//  Copyright © 2019 urklc. All rights reserved.
//

import UIKit

final class DetailViewController: UIViewController {

    var viewModel: DetailViewModel!
    var router: GenericRouting?

    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var reminderSwitch: UISwitch!
    @IBOutlet weak var reminderDatePicker: UIDatePicker!

    override func viewDidLoad() {
        super.viewDidLoad()

        detailTextView.backgroundColor = .lightGray

        reminderDatePicker.minimumDate = viewModel.minimumAllowedDate
        reminderDatePicker.datePickerMode = .dateAndTime
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        detailTextView.becomeFirstResponder()
    }

    @IBAction func saveButtonTapped() {
        let reminderDate = reminderSwitch.isOn ? reminderDatePicker.date : nil
        viewModel.addTodoItem(detail: detailTextView.text, reminder: reminderDate)
        router?.dismiss(current: self)
    }
}
