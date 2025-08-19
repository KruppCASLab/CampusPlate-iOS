//
//  PinVerificationViewController.swift
//  BWFoodApp
//
//  Created by Dan Fitzgerald on 1/15/19.
//  Copyright © 2019 Dan Fitzgerald. All rights reserved.
//

import UIKit

class PinVerificationViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var pinInput: UITextField!
    
    @IBOutlet weak var continueButton: UIButton!
    
    
    @IBAction func resendPin(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pinInput.delegate = self
        pinInput.returnKeyType = .done
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        continueButton.isEnabled = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        pinInput.resignFirstResponder()
        
        return true
    }
    
   
    @IBAction func resendCode(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if pinInput.text?.isEmpty == true {
            
            print("pin is invalid")

            return false
        }else if pinInput.text?.isEmpty == false{
            
            continueButton.isEnabled = true
            
            return true
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
