//
//  SecondViewController.swift
//  BWFoodApp
//
//  Created by Dan Fitzgerald on 7/14/18.
//  Copyright © 2018 Dan Fitzgerald. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController,UITextFieldDelegate {

    
    @IBOutlet weak var textfield1: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        textfield1.delegate = self
        textfield1.returnKeyType = .done
    
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textfield1.resignFirstResponder()
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
