//
//  ViewController.swift
//  Lab-EnterToWinAContest
//
//  Created by Benjamin Reeps on 1/4/21.
//

import UIKit

class ViewController: UIViewController {
    var emailIsValid = false

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        submitButton.layer.cornerRadius = 22.0
        
        
    }
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        
    }
    
    func checkEmailStatus() {
        if emailTextField.text?.contains("@" + ".com") != nil {
            emailIsValid = true
        } else {
            emailIsValid = false
        }
    }

}

