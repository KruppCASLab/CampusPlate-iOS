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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        locationInput.delegate = self
        foodInput.delegate = self
        timeInput.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        locationInput.resignFirstResponder()
        foodInput.resignFirstResponder()
        timeInput.resignFirstResponder()
        
        return true
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if identifier == "postFood"{
            
            if locationInput.text?.isEmpty == true {
                return false
            }
            
            if foodInput.text?.isEmpty == true {
                return false
            }
            
            if timeInput.text?.isEmpty == true {
                return false
            }
        }
        
        return true
}
    


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        let vc = segue.destination as! PostingConfirmationViewController
        vc.food = self.foodInput.text
        vc.location = self.locationInput.text
        vc.time = self.timeInput.text
    }
    

}
