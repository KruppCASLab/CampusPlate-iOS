//
//  NavigationController.swift
//  BWFoodApp
//
//  Created by Dan Fitzgerald on 4/18/20.
//  Copyright © 2020 Dan Fitzgerald. All rights reserved.
//

import UIKit

class NavigationController : UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let creds = CredentialManager.getCredential() {
            let mapController = MapViewController()
            viewControllers = [mapController]
        }else{
            perform(#selector(showSignUpScreen), with: nil, afterDelay: 0.01)
        }
    }
    
    @objc func showSignUpScreen() {
        let signUpScreen = CaterULoginScreenVC()
        present(signUpScreen, animated: true, completion: {
            
        })
    }
}


