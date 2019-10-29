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
    @IBOutlet weak var locationSubLocation: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    
    @IBOutlet weak var postedTime: UILabel!
    @IBOutlet weak var expireTime: UILabel!
    @IBOutlet weak var availableLeft: UILabel!
   
    @IBOutlet weak var foodImageView: UIImageView!

    @IBOutlet weak var claimButton: UIButton!
    
    
    
    public var listing:WSListing!
    public var indexPathOfListing:IndexPath!
    
    @IBAction func pickUpButton(_ sender: Any) {
        // TODO: Remove the item from model
        ListingModel.getSharedInstance().removeListing(index: self.indexPathOfListing.row)
        
        self.presentingViewController?.dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func cancelButton(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    

    @IBAction func quantityStepper(_ sender: UIStepper) {
        
        quantityLabel.text = Int(sender.value).description
        
        sender.maximumValue = Double(availableLeft.text!) ?? 0
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationSubLocation.text = listing.locationDescription ?? " "
        
        foodImageView.layer.borderWidth = 2
        foodImageView.layer.cornerRadius = 15
        foodImageView.layer.borderColor = UIColor.systemOrange.cgColor
        
        claimButton.layer.cornerRadius = 20
        
        let available : Int = listing.quantity ?? 0
        var availableStr = String(available)
        
    
        self.foodPickUpLabel.text = listing.title
        self.availableLeft.text = availableStr
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .medium
        dateFormatter.dateStyle = .medium

        
       self.postedTime.text = dateFormatter.string(from: Date(timeIntervalSince1970: listing!.creationTime!))

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
