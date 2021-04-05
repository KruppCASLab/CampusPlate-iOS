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
    
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        enterPinField.delegate = self
        enterPinField.returnKeyType = .done
        
        submitButton.isEnabled = false
        submitButton.alpha = 0.5
        // Do any additional setup after loading the view.
    }
    
    @IBAction func reEnterInfoButton(_ sender: Any) {
        
        self.delegate?.resetRegisterButton()
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let text = (enterPinField.text! as NSString).replacingCharacters(in: range, with: string)
        
        if text.isEmpty {
        submitButton.isEnabled = false
        submitButton.alpha = 0.5
        } else {
            submitButton.isEnabled = true
            submitButton.alpha = 1.0
        }
        return true
    }
    
    @IBAction func viewTapped(_ sender: Any) {
        enterPinField.resignFirstResponder()
    }
    
    @IBAction func submitPinButton(_ sender: Any) {
        
        let pinEntered = Int(enterPinField.text!)!
        
        let user = User(userName: userName, pin: pinEntered)
        
        userModel.updateAccountVerificationFlag(userName: user.userName ?? "", pin: user.pin ?? 0) { (completed) in
            if (!completed) {
                let alert = UIAlertController(title: "Incorrect Pin", message: "The pin you entered is not what we have on file, please go back and reenter your email.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (UIAlertAction) in
                    alert.dismiss(animated: true, completion: nil)
                }))
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
        
//        if identifier == "goToRegisterScreen" {
//            return true
//        }else{
//            return true
//        }
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
