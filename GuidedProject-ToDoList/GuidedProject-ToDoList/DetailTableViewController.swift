//
//  DetailTableViewController.swift
//  GuidedProject-ToDoList
//
//  Created by Benjamin Reeps on 12/12/20.
//

import Foundation
import UIKit

class DetailTableViewController: UITableViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var isCompleteButton: UIButton!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateSaveButton()
        updateDueDateLabel(date: dueDatePicker.date)
        // Make initial date for the date picker 24hrs from the present
        dueDatePicker.date = Date.init(timeIntervalSinceNow: 24*60*60)
    }
    
    @IBAction func isCompleteButtonTapped(_ sender: UIButton) {
        isCompleteButton.isSelected = !isCompleteButton.isSelected
        
        if isCompleteButton.isSelected {
            isCompleteButton.tintColor = .systemOrange
        } else {
            isCompleteButton.tintColor = .systemGreen
        }
    }
    
    @IBAction func returnPressed(_ sender: UITextField) {
        // Ensures that the keyboard will dissapear when the user presses the return key after typing
        titleTextField.resignFirstResponder()
    }
    
    
    @IBAction func textEditingChanged(_ sender: UITextField) {
        // Ensures that save button state is updated when text for the title is changed
        updateSaveButton()
    }
    
    func updateSaveButton() {
        let text = titleTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
    @IBAction func dueDatePickerChanged(_ sender: UIDatePicker) {
        updateDueDateLabel(date: dueDatePicker.date)
    }
    func updateDueDateLabel(date: Date) {
        dueDateLabel.text = ToDo.dueDateFormatter.string(from: date)
    }
    
}