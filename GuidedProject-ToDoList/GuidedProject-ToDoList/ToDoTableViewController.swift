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
}
