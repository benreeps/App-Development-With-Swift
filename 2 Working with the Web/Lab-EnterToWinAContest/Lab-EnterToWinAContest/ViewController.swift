//
//  ViewController.swift
//  Lab-EnterToWinAContest
//
//  Created by Benjamin Reeps on 1/4/21.
//

import UIKit

class ViewController: UIViewController {
    var emailList: [Email] = []
    
    var emailIsValid = false {
        didSet {
            if emailIsValid {
                return
                
            } else {
                let buttonBackgorund: UIView
                let translateTransform = CGAffineTransform(translationX: 20, y: 0)
                buttonBackgorund = emailTextField
                
                UIView.animate(withDuration: 0.25, animations: {
                    self.emailTextField.transform = translateTransform
                }) { (_) in UIView.animate(withDuration: 0.25, animations: {
                    buttonBackgorund.transform = CGAffineTransform.identity
                    })
                
                }
            }
        }
    }
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        submitButton.layer.cornerRadius = 22.0
        
        
    }
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        checkEmailStatus()
        
        
    }
    
    func checkEmailStatus() {
        if emailTextField.text?.contains("@" + ".com") != nil {
            emailIsValid = !emailIsValid
        } else {
            emailIsValid = !emailIsValid
        }
    }
    
}

