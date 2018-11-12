//
//  SecondViewController.swift
//  BWFoodApp
//
//  Created by Dan Fitzgerald on 7/14/18.
//  Copyright © 2018 Dan Fitzgerald. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController,UITextFieldDelegate {

    
    @IBOutlet weak var textField1: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        textField1.delegate = self
        textField1.returnKeyType = .done
    
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField1.resignFirstResponder()
        return true
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if identifier == "Email"{
            
            if textField1.text?.isEmpty == true {
                print("needs a valid email address")
                
                return false
            } else {
                print("valid email")
            }
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
