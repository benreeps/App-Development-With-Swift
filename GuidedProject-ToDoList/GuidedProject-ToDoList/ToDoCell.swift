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
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var isCompleteButton: UIButton!
    @IBAction func completeButtonTapped(_ sender: UIButton) {
        let orangeTag = UIImage(named: "icons8-tag-window-96 (3)")
        let greenTag = UIImage(named: "icons8-tag-window-96 (5)")
        
        isCompleteButton.isSelected = !isCompleteButton.isSelected
        
        if isCompleteButton.isSelected {
            isCompleteButton.setImage(greenTag, for: .normal)
        } else {
            isCompleteButton.setImage(orangeTag, for: .normal)
        }
        
        delegate?.tagTapped(sender: self)
    }
    var delegate: ToDoCellDelegate?
    
}
