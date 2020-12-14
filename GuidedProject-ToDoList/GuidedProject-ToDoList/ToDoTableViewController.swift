//
//  ToDoTableViewController.swift
//  GuidedProject-ToDoList
//
//  Created by Benjamin Reeps on 12/12/20.
//

import Foundation
import UIKit

class ToDoTableViewController: UITableViewController {
    
    var todos = [ToDo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        editButtonItem.tintColor = .systemOrange
        
        if let savedToDos = ToDo.loadToDos() {
            todos = savedToDos
        } else {
            let sampleToDos = ToDo.loadSampleToDos()
            todos = sampleToDos
        }
        
    }
    
    
    // MARK:- TableView Data
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell") else {
            fatalError("Could not dequeue cell")
        }
        let todo = todos[indexPath.row]
        cell.textLabel?.text = todo.title
        return cell 
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
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
            tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
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
