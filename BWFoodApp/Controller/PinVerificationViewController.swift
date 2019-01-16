//
//  PinVerificationViewController.swift
//  BWFoodApp
//
//  Created by Dan Fitzgerald on 1/15/19.
//  Copyright © 2019 Dan Fitzgerald. All rights reserved.
//

import UIKit

class PinVerificationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func resendEmail(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
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
