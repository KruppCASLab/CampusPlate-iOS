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
        if CredentialManager.getCredential() != nil {
            performSegue(withIdentifier: "toApplication", sender: nil)
        }else{
            performSegue(withIdentifier: "toSignUpScreen", sender: nil)
        }
    }
}
