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
    
}
