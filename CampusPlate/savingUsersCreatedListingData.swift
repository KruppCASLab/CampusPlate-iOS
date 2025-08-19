//
//  savingUsersCreatedListingData.swift
//  BWFoodApp
//
//  Created by Dan Fitzgerald on 7/19/18.
//  Copyright © 2018 Dan Fitzgerald. All rights reserved.
//

import UIKit

class savingUsersCreatedListingData: UIViewController {
    
    @IBOutlet weak var locationInput: UITextField!
  
    @IBOutlet weak var foodInput: UITextField!
    @IBOutlet weak var timeInput: UITextField!
    
    @IBOutlet weak var confirmedLocation: UILabel!
    @IBOutlet weak var confirmedFood: UILabel!
    @IBOutlet weak var confirmedTime: UILabel!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveUserInput(_ sender: Any) {
        confirmedLocation.text = locationInput.text
        confirmedFood.text = foodInput.text
        confirmedTime.text = timeInput.text
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
