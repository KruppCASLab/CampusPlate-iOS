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


class EnterPinVC: UIViewController {
    
    let userModel = UserModel.getSharedInstance()
    
    @IBOutlet weak var enterPinField: UITextField!
    
    public var delegate: EnterPinDelegate?
    
    var userName = ""
    

    @IBOutlet weak var label: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = userName
        // Do any additional setup after loading the view.
    }
    
    @IBAction func reEnterInfoButton(_ sender: Any) {
        
        self.delegate?.resetRegisterButton()
        
    }
    
    @IBAction func submitPinButton(_ sender: Any) {
        
        let pinEntered = Int(enterPinField.text ?? "0") ?? 0
        
    userModel.updateAccountVerificationFlag(userName: userName, pin: pinEntered) { (completed) in
            if (!completed) {
                let alert = UIAlertController(title: "Failed!", message: "Failed", preferredStyle: .alert)
                DispatchQueue.main.async {
                    self.present(alert, animated: true, completion: nil)
                }
            }else{
                //perform segue to next screen
            }
        }
        
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
