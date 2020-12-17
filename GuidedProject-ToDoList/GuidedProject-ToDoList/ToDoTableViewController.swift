//
//  ToDoTableViewController.swift
//  GuidedProject-ToDoList
//
//  Created by Benjamin Reeps on 12/12/20.
//

import Foundation
import UIKit

class ToDoTableViewController: UITableViewController, ToDoCellDelegate {
    
   // Protocol method
    func tagTapped(sender: ToDoCell) {
        if let indexPath = tableView.indexPath(for: sender) {
            var todo = todos[indexPath.row]
            todo.isComplete = !todo.isComplete
            todos[indexPath.row] = todo
            tableView.reloadRows(at: [indexPath], with: .automatic)
            ToDo.saveToDos(todos)
        }
        
    }
   
    
    
    var todos = [ToDo]()
    var cellNumbers = [CellNumber]()
    var items = [[Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        editButtonItem.tintColor = .systemOrange
    
        if let savedCellNumbers = CellNumber.loadCellNumbers() {
            cellNumbers = savedCellNumbers
        } else {
            let sampleCellNumbers = CellNumber.loadSampleCellNumbers()
            cellNumbers = sampleCellNumbers
        }
        
        if let savedToDos = ToDo.loadToDos() {
            todos = savedToDos
        } else {
            let sampleToDos = ToDo.loadSampleToDos()
            todos = sampleToDos
        }
        
        items.append(todos)
        items.append(cellNumbers)
        
    }
    
    
    // MARK:- TableView Delegates
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        if indexPath.row < todos.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell") as! ToDoCell
            let todo = todos[indexPath.row]
            let orangeTag = UIImage(named: "icons8-tag-window-96 (3)")
            let greenTag = UIImage(named: "icons8-tag-window-96 (5)")
            let cellNumber: String = String(indexPath.row + 1)
            
            cell.toDoNumber.text = cellNumber
            cell.titleLabel.text = todo.title
            cell.isCompleteButton.isSelected = todo.isComplete
            
            if todo.isComplete {
                cell.isCompleteButton.setImage(greenTag, for: .normal)
            } else {
                cell.isCompleteButton.setImage(orangeTag, for: .normal)
            }
            
            cell.delegate = self
            return cell
            
        }else if indexPath.row >= todos.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NumberCell") as! NumberCell
            let cellNumber = cellNumbers[indexPath.row]
            let cellNumberString = String(cellNumber.number)
           
            cell.cellNumberLabel.text = cellNumberString
            
            return cell
            
        } else {
            fatalError()
        }
    }
     /*   guard let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell") as? ToDoCell else { fatalError("Could not dequeue cell")}
            let todo = todos[indexPath.row]
            let orangeTag = UIImage(named: "icons8-tag-window-96 (3)")
            let greenTag = UIImage(named: "icons8-tag-window-96 (5)")
            let cellNumber: String = String(indexPath.row + 1)
            
            cell.toDoNumber.text = cellNumber
            cell.titleLabel.text = todo.title
            cell.isCompleteButton.isSelected = todo.isComplete
            
            if todo.isComplete {
                cell.isCompleteButton.setImage(greenTag, for: .normal)
            } else {
                cell.isCompleteButton.setImage(orangeTag, for: .normal)
            }
            
            cell.delegate = self
            return cell
        */
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.row > (todos.count - 1) {
            return false
        } else {
        return true
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todos.remove(at: indexPath.row)
            //tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
            ToDo.saveToDos(todos)
        }
    }
    // MARK:- Segue Configuration
    
    // retrieves info from todo created in editor, assigns it to be a todo in todos, creates a new cell for todo
    @IBAction func unwindToDoStuffList(segue: UIStoryboardSegue) {
        guard segue.identifier == "SaveUnwind" else {return}
        
        let sourceViewController = segue.source as! DetailTableViewController
        
        if let todo = sourceViewController.todo {
            // This if statement checks to see if you had previously selected a todo list item to edit or if you had previously selected the + bar button item to create a new list item. If you are editing an item in a previously selected row this statement will apply your edits to that row rather than create a new entry. 
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                todos[selectedIndexPath.row] = todo
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
            let newIndexPath = IndexPath(row: todos.count, section: 0)
            
            todos.append(todo)
                tableView.reloadRows(at: [newIndexPath], with: .none)
            //tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
        ToDo.saveToDos(todos)
    }
    // retrieves info from selected cell in the todo list and sends the information to the detailtbc 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails" {
            let detailTableViewController = segue.destination as! DetailTableViewController
            let indexPath = tableView.indexPathForSelectedRow!
            let selectedToDo = todos[indexPath.row]
            detailTableViewController.todo = selectedToDo
        }
    }
}
