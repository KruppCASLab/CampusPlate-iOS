//
//  CaterULoginScreenVC.swift
//  BWFoodApp
//
//  Created by Dan Fitzgerald on 2/3/19.
//  Copyright © 2019 Dan Fitzgerald. All rights reserved.
//

import UIKit

class CaterULoginScreenVC: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var studentEmailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
   
    @IBOutlet weak var continueButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        studentEmailField.delegate = self
        studentEmailField.returnKeyType = .done
        
        passwordField.delegate = self
        passwordField.returnKeyType = .done
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        continueButton.isEnabled = false
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        studentEmailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        return true
    }
    
    func loginSuccessful() {
        continueButton.isEnabled = true
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if (studentEmailField.text?.isEmpty == true) || (passwordField.text?.isEmpty == true) {
            print("needs valid email")
            print("needs valid password")
            
            return false
        }else{
        
            print("email is valid")
            print("password is valid")
            
            
            loginSuccessful()
        }
     
        return true
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
