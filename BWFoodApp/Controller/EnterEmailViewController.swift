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
    
        emailField.delegate = self
        emailField.returnKeyType = .done
        
        enableRegisterButton()
    }
    
    var user:User = User(userName: "")
    
    @IBAction func register(_ sender: UIButton) {
        disableRegisterButton()
        
        let emailAddress = (emailField.text) ?? ""
        
        // Convert field to lower case and trim characters from it that may cause an issue, set it back on the view
        user = User(userName: emailAddress.lowercased().trimmingCharacters(in: .whitespacesAndNewlines))
        emailField.text = user.userName;
        
        
        userModel.addUser(user:user) { (completed) in
            self.enableRegisterButton()
            if (!completed) {
                let alert = UIAlertController(title: "Error", message: "We were unable to register this account. Please check your internet connection and the email address and try again.", preferredStyle: .alert)
                alert.addAction(UIAlertAction.init(title: "Ok", style: .default, handler: nil));
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
    
    func disableRegisterButton() {
        DispatchQueue.main.async {
            self.registerButton.isEnabled = false
            self.registerButton.alpha = 0.5
        }
    }
    func enableRegisterButton() {
        DispatchQueue.main.async {
            self.registerButton.isEnabled = true
            self.registerButton.alpha = 1.0
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailField.resignFirstResponder()
        return true
    }
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? EnterPinViewController {
            destinationVC.userName = user.userName!
        }
     }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return false
    }

}
