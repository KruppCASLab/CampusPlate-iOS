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
    public var indexPathOfListing:IndexPath!
    
    @IBAction func pickUpButton(_ sender: Any) {
        // TODO: Remove the item from model
        ListingModel.getSharedInstance().removeListing(index: self.indexPathOfListing.row)
        
        self.presentingViewController?.dismiss(animated: true, completion: nil)
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.foodPickUpLabel.text = listing.food
        self.locationPickUplabel.text = listing.location
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
