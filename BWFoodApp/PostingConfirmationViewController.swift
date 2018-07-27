//
//  PostingConfirmationViewController.swift
//  BWFoodApp
//
//  Created by Dan Fitzgerald on 7/23/18.
//  Copyright © 2018 Dan Fitzgerald. All rights reserved.
//

import UIKit

class PostingConfirmationViewController: UIViewController {
    
    public var location:String!
    public var food:String!
    public var time:String!

    @IBOutlet weak var timeTextfield: UILabel!
    @IBOutlet weak var foodTextField: UILabel!
    @IBOutlet weak var locationTextField: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        DispatchQueue.main.async {
            self.timeTextfield.text = self.time
            self.locationTextField.text = self.location
            self.foodTextField.text = self.food
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
