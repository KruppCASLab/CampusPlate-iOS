//
//  pickUpFoodViewController.swift
//  BWFoodApp
//
//  Created by Dan Fitzgerald on 8/3/18.
//  Copyright © 2018 Dan Fitzgerald. All rights reserved.
//

import UIKit

class PickUpFoodViewController: UIViewController {
    
    @IBOutlet weak var foodPickUpLabel: UILabel!
    @IBOutlet weak var locationPickUplabel: UILabel!
    @IBOutlet weak var timePickUplabel: UILabel!
    
    public var listing:Listing!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.foodPickUpLabel.text = listing.food
        //self.locationPickUplabel.text = listing.coordinate
        self.timePickUplabel.text = listing.time
        

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
