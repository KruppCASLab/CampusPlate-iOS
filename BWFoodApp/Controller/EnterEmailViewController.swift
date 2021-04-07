//
//  CaterULoginScreenVC.swift
//  BWFoodApp
//
//  Created by Dan Fitzgerald on 2/3/19.
//  Copyright © 2019 Dan Fitzgerald. All rights reserved.
//

import UIKit

class EnterEmailViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    let userModel = UserModel.getSharedInstance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        registerButton.isEnabled = true
        registerButton.alpha = 1.0

        emailField.delegate = self
        emailField.returnKeyType = .done
    }
    
    var user:User = User(userName: "")
    
    @IBAction func register(_ sender: UIButton) {
        registerButton.isEnabled = false
        registerButton.alpha = 0.5
        
        let emailAddress = (emailField.text) ?? ""
        
        user = User(userName: emailAddress)
        
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
        
        emailField.resignFirstResponder()
        
        return true
    }
    
    func resetRegisterButton(){
        registerButton.isEnabled = true
        registerButton.alpha = 1.0
        
        performSegue(withIdentifier: "goToRegisterScreen", sender: nil)
        
    }
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
        //TODO: DO IT HERE AND PASS THE USERNAME!
        if let destinationVC = segue.destination as? EnterPinVC {
            
            destinationVC.userName = user.userName!
            
        }
        
        
     }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return false
    }
     
    
    
}
