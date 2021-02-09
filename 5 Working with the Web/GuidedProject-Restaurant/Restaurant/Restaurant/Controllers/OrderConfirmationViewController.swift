//
//  OrderConfirmationViewController.swift
//  Restaurant
//
//  Created by Benjamin Reeps on 2/1/21.
//

import Foundation
import UIKit

class OrderConfirmationViewController: UIViewController {
    
    @IBOutlet weak var timeRemainingLabel: UILabel!
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var statusView: UIView!
    
    var minutes: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dismissButton.layer.cornerRadius = 5.0
        statusView.layer.cornerRadius = 7.0
        statusView.layer.borderWidth = 5.0
        statusView.layer.borderColor = UIColor.red.cgColor
        
        timeRemainingLabel.text = "\(minutes!) minutes."
    }
}
