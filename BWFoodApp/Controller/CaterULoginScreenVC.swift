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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        studentEmailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        return true
    }
    
    
    @IBAction func goToListingsScreen(_ sender: Any) {
        
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
