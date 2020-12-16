//
//  ToDoCell.swift
//  GuidedProject-ToDoList
//
//  Created by Benjamin Reeps on 12/14/20.
//

import Foundation
import UIKit

@objc protocol ToDoCellDelegate: class {
    func tagTapped(sender: ToDoCell)
    
}
class ToDoCell: UITableViewCell {
    var delegate: ToDoCellDelegate?
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var isCompleteButton: UIButton!
    @IBOutlet weak var toDoNumber: UILabel!
    
    
    
    @IBAction func completeButtonTapped(_ sender: UIButton) {
     
        delegate?.tagTapped(sender: self)
    }
    
    
}
