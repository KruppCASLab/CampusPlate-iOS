//
//  InitialCheckScreenViewController.swift
//  BWFoodApp
//
//  Created by Dan Fitzgerald on 4/25/20.
//  Copyright © 2020 Dan Fitzgerald. All rights reserved.
//

import UIKit

class InitialCheckScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if let creds = CredentialManager.getCredential(){
            performSegue(withIdentifier: <#T##String#>, sender: <#T##Any?#>)
        }else{
            performSegue(withIdentifier: <#T##String#>, sender: <#T##Any?#>)
        }
        // Do any additional setup after loading the view.
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
