//
//  createNewListing.swift
//  BWFoodApp
//
//  Created by Dan Fitzgerald on 7/21/18.
//  Copyright © 2018 Dan Fitzgerald. All rights reserved.
//

import UIKit

class createNewListing: UIViewController, UITextFieldDelegate {
    
   // Setting up outlets
    @IBOutlet weak var locationInput: UITextField!
    @IBOutlet weak var foodInput: UITextField!
    @IBOutlet weak var timeInput: UITextField!
    
    @IBOutlet weak var locationConf: UILabel!
    @IBOutlet weak var foodConf: UILabel!
    @IBOutlet weak var timeConf: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        locationInput?.delegate = self
        foodInput?.delegate = self
        timeInput?.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        locationInput.resignFirstResponder()
        foodInput.resignFirstResponder()
        timeInput.resignFirstResponder()
        
        return true
    }
    
    @IBAction func next(_ sender: Any) {
        locationConf.text = locationInput.text
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
