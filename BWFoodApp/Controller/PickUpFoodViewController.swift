//
//  pickUpFoodViewController.swift
//  BWFoodApp
//
//  Created by Dan Fitzgerald on 8/3/18.
//  Copyright © 2018 Dan Fitzgerald. All rights reserved.
//

import UIKit
import CoreGraphics

class PickUpFoodViewController: UIViewController {

    let listingModel = ListingModel.getSharedInstance()
    
    public var delegate:CreateNewListingDelegate?
    
    @IBOutlet weak var navBar: UINavigationItem!
    
    @IBOutlet weak var locationSubLocation: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    
    @IBOutlet weak var postedTime: UILabel!
    @IBOutlet weak var expireTime: UILabel!
    @IBOutlet weak var availableLeft: UILabel!
   
    @IBOutlet weak var foodImageView: UIImageView!

    @IBOutlet weak var claimButton: UIButton!
    
    @IBOutlet weak var ActivityIndicator: UIActivityIndicatorView!
    
    
    public var listing:WSListing!
    public var indexPathOfListing:IndexPath!
    
    @IBAction func pickUpButton(_ sender: Any) {
        // TODO: Remove the item from model
        ListingModel.getSharedInstance().removeListing(index: self.indexPathOfListing.row)
        
        self.presentingViewController?.dismiss(animated: true, completion: nil)
        
    }

    
    @IBAction func claimButton(_ sender: Any) {
        
        claimButton.isEnabled = false
        ActivityIndicator.isHidden = false
        
        ActivityIndicator.startAnimating()
        claimButton.alpha = 0.5
        
        
        listingModel.updateQuantity(listingID: listing.listingId!, releventQuantity: Int(quantityLabel.text!)!) { (completed) in
            if (!completed) {
                let alert = UIAlertController(title: "Failed!", message: "Failed", preferredStyle: .alert)
                DispatchQueue.main.async {
                    self.present(alert, animated: true, completion: nil)
                }
            }else {
                DispatchQueue.main.async {
                    self.delegate?.didComplete()
                }
           }
            
        }
        
        
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
    
        locationSubLocation.text = listing.locationDescription
        ActivityIndicator.isHidden = true
        
        let dataDecoded : Data = Data(base64Encoded: listing.image! , options: .ignoreUnknownCharacters)!
        let decodedimage = UIImage(data: dataDecoded)
        foodImageView.image = decodedimage

        foodImageView.image = decodedimage
        
        navBar.title = listing.title
        
        foodImageView.layer.borderWidth = 2
        foodImageView.layer.borderColor = UIColor.systemOrange.cgColor
        
        claimButton.layer.cornerRadius = 20
        
        let available : Int = listing.quantity ?? 0
        var availableStr = String(available)
        
    
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
