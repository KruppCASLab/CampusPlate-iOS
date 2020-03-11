//
//  EnterPinVC.swift
//  BWFoodApp
//
//  Created by Dan Fitzgerald on 2/5/20.
//  Copyright © 2020 Dan Fitzgerald. All rights reserved.
//

import UIKit

protocol EnterPinDelegate {
    func resetRegisterButton()
}


class EnterPinVC: UIViewController, UITextFieldDelegate {
    
    let userModel = UserModel.getSharedInstance()
    
    @IBOutlet weak var enterPinField: UITextField!
    
    public var delegate: EnterPinDelegate?
    
    var userName = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        enterPinField.delegate = self
        enterPinField.returnKeyType = .done
        // Do any additional setup after loading the view.
    }
    
    @IBAction func reEnterInfoButton(_ sender: Any) {
        
        self.delegate?.resetRegisterButton()
        
    }
    
    @IBAction func submitPinButton(_ sender: Any) {
        
        let pinEntered = Int(enterPinField.text!)!
        
        let user = User(userName: userName, pin: pinEntered)
        
        userModel.updateAccountVerificationFlag(userName: user.userName ?? "", pin: user.pin ?? 0) { (completed) in
            if (!completed) {
                let alert = UIAlertController(title: "Incorrect Pin", message: "The pin you entered is not what we have on file, please go back and reenter your email.", preferredStyle: .alert)
                DispatchQueue.main.async {
                    self.present(alert, animated: true, completion: nil)
                }
            }else{
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "goToMap", sender: nil)
                }
            }
        }
    
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        enterPinField.resignFirstResponder()
        
        return true
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return false
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
