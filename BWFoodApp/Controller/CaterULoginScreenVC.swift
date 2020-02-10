//
//  CaterULoginScreenVC.swift
//  BWFoodApp
//
//  Created by Dan Fitzgerald on 2/3/19.
//  Copyright © 2019 Dan Fitzgerald. All rights reserved.
//

import UIKit

class CaterULoginScreenVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var studentEmailLabel: UILabel!
    
    @IBOutlet weak var passwordLabel: UILabel!
    
    @IBOutlet weak var studentEmailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    
    let userModel = UserModel.getSharedInstance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signInButton.isEnabled = true
        signInButton.alpha = 1.0
        
        let leftView = UITextField(frame: CGRect(x: 10, y: 0, width: 7, height: 26))
        
        let leftView2 = UITextField(frame: CGRect(x: 10, y: 0, width: 7, height: 26))
        
        studentEmailField.layer.cornerRadius = 16
        studentEmailField.layer.borderWidth = 1
        studentEmailField.layer.borderColor = UIColor.systemOrange.cgColor
        
        studentEmailField.leftView = leftView
        studentEmailField.leftViewMode = .always
        studentEmailField.contentVerticalAlignment = .center
        
        studentEmailField.delegate = self
        studentEmailField.returnKeyType = .done
        
        passwordField.layer.cornerRadius = 16
        passwordField.layer.borderWidth = 1
        passwordField.layer.borderColor = UIColor.systemOrange.cgColor
        
        passwordField.leftView = leftView2
        passwordField.leftViewMode = .always
        passwordField.contentVerticalAlignment = .center
        
        passwordField.delegate = self
        passwordField.returnKeyType = .done
        
        signInButton.layer.cornerRadius = 16
        
    }
    
    
    @IBAction func register(_ sender: Any) {
        
        signInButton.isEnabled = false
        signInButton.alpha = 0.5
        
        let emailAddress = (studentEmailField.text) ?? ""
        let password = (passwordField.text) ?? ""
        
        var username = ""
        
        if let index = emailAddress.firstIndex(of: "@") {
            username = String(emailAddress.prefix(upTo: index))
        }
        
        let user = User(username: username, password: password, emailAddress: emailAddress)
        
        userModel.addUser(user:user) { (completed) in
            if (!completed) {
                let alert = UIAlertController(title: "Failed!", message: "Failed", preferredStyle: .alert)
                DispatchQueue.main.async {
                    self.present(alert, animated: true, completion: nil)
                }
                
            }
            else {
                DispatchQueue.main.async {
                    
                    self.performSegue(withIdentifier: "goToPinScreen", sender: nil)
                    
                }
            }
            
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        studentEmailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        return true
    }
    
    func resetRegisterButton(){
        signInButton.isEnabled = true
        signInButton.alpha = 1.0
        
        performSegue(withIdentifier: "goToRegisterScreen", sender: nil)
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
}
