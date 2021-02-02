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
    
    var minutes: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dismissButton.layer.cornerRadius = 5.0
    }
    
   
}
