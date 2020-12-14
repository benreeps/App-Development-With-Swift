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
            let newIndexPath = IndexPath(row: todos.count, section: 0)
            
            todos.append(todo)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }
}
