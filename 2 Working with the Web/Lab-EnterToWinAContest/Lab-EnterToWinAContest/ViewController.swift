//
//  ViewController.swift
//  Lab-EnterToWinAContest
//
//  Created by Benjamin Reeps on 1/4/21.
//

import UIKit

class ViewController: UIViewController {
    var emailList: [Email] = []
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        submitButton.layer.cornerRadius = 22.0
        emailTextField.layer.borderColor = UIColor.lightGray.cgColor
        emailTextField.layer.borderWidth = 0.3
        emailTextField.layer.cornerRadius = 17
        emailTextField.clipsToBounds = true
        
    }
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        checkEmailStatus()
        emailTextField.resignFirstResponder()

    }
    
    @IBAction func isEditingEmail(_ sender: UITextField) {
        emailTextField.layer.borderColor = UIColor.lightGray.cgColor
        emailTextField.layer.borderWidth = 0.3
        emailTextField.layer.cornerRadius = 17
        
    }
    
    
    func checkEmailStatus() {
        let email = self.emailTextField.text
        let emailView: UIView = self.emailTextField
        
        if email!.range(of: "@") != nil {
            return
            
        } else {
            let animation = CABasicAnimation(keyPath: "position")
            animation.duration = 0.07
            animation.repeatCount = 4
            animation.autoreverses = true
            animation.fromValue = NSValue(cgPoint: CGPoint(x: emailView.center.x - 10, y: emailView.center.y))
            animation.toValue = NSValue(cgPoint: CGPoint(x: emailView.center.x + 10, y: emailView.center.y))
            
            emailView.layer.borderWidth = 1
            emailView.layer.borderColor = UIColor.red.cgColor
            emailView.layer.add(animation, forKey: "position")
            
        }
    }
    
   
}
