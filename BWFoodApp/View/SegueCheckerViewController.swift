//
//  SegueCheckerViewController.swift
//  BWFoodApp
//
//  Created by Dan Fitzgerald on 4/18/20.
//  Copyright © 2020 Dan Fitzgerald. All rights reserved.
//

import UIKit

class SegueCheckerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
             //        if let cred = CredentialManager.getCredential(){
        //        //            performSegue(withIdentifier: "toSignUpScreen", sender: nil)
        //        //        }else{
        //        //            performSegue(withIdentifier: "toApplication", sender: nil)
        //        //
        //        //        }
        //
                if CredentialManager.getCredential() != nil {
                    performSegue(withIdentifier: "toApplication", sender: nil)
                }else{
                    performSegue(withIdentifier: "toSignUpScreen", sender: nil)
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
