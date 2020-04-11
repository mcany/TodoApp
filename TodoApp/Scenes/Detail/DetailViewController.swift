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
    @IBOutlet weak var reminderTextField: DatePickerTextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        detailTextView.layer.borderWidth = 1.0
        reminderTextField.placeholder = "Set reminder (Optional)"
        reminderTextField.pickerSetup = (viewModel.minimumAllowedDate, Date.distantFuture, viewModel.minimumAllowedDate)

        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
        navigationItem.rightBarButtonItem = saveButton
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        detailTextView.becomeFirstResponder()
    }

    @objc func saveButtonTapped() {
        guard let detailText = detailTextView.text,
            !detailText.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty else {
                let alertController = UIAlertController(
                    title: "Error",
                    message: "Please set description for the item!",
                preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
            return
        }

        viewModel.addTodoItem(detail: detailText, reminder: reminderTextField.currentDate)
        router?.dismiss(current: self)
    }
}
