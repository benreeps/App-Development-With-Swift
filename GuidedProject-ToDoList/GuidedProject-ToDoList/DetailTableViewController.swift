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
    @IBOutlet weak var notesLabel: UILabel!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var isEditingDate = false {
        didSet {
            dueDatePicker.isHidden = !isEditingDate
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    var isEditingNotes = false {
        didSet {
            if !isEditingNotes {
            notesTextView.becomeFirstResponder()
            } else {
                notesTextView.resignFirstResponder()
            }
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    // “Since the static table view controller will deal with one model at a time, you'll add an optional model property to the class definition. (It's optional because the property will be nil until the Save button is tapped and the property can be given a value.)”
    var todo: ToDo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let todo = todo {
            navigationItem.title = "New Stuff To Do"
            titleTextField.text = todo.title
            dueDatePicker.date = todo.dueDate
            isCompleteButton.isSelected = todo.isComplete
            notesTextView.text = todo.notes
        } else {
            // Make initial date for the date picker 24hrs from the present
            dueDatePicker.date = Date.init(timeIntervalSinceNow: 24*60*60)
        }
        updateSaveButton()
        updateDueDateLabel(date: dueDatePicker.date)
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
    // MARK:- TableView Delegates
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let normalCellHeight = CGFloat(44)
        let largeCellHeight = CGFloat(200)
        
        switch(indexPath) {
        case[1,1]:
            return isEditingDate ?  largeCellHeight : 0
        
        case[2,1]:
            return largeCellHeight 
            
        default: return normalCellHeight
        
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch (indexPath) {
        case [1,0]:
            isEditingDate = !isEditingDate
            
            dueDateLabel.textColor = isEditingDate ? .black : tableView.tintColor
            
        case [2,0]:
            isEditingNotes = !isEditingNotes
            // When cell is tapped the desired text view will be displayed and assigned to be first responder with blinking cursor.
            
        default:
            break
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "SaveUnwind" else {return}
        // titleTextField.text needs to be unwrapped because the title property for a ToDo is not optional
        let title = titleTextField.text!
        let isComplete = isCompleteButton.isSelected
        let date = dueDatePicker.date
        let notes = notesTextView.text
        
        todo = ToDo(title: title, isComplete: isComplete, dueDate: date, notes: notes)
    }
    
}
