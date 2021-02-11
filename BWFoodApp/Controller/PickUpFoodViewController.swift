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
    let foodStopModel = FoodStopModel.getSharedInstance()
    
    public var delegate:CreateNewListingDelegate?
    
    @IBOutlet weak var daysPosted: UILabel!
    
    @IBOutlet weak var foodLabel: UILabel!
    
    
    
    @IBOutlet weak var pickUpLocation: UILabel!
    @IBOutlet weak var foodStopCircleView: UIView!
    
    @IBOutlet weak var foodImageView: UIImageView!
    
    @IBOutlet weak var quantityLabel: UILabel!
    
    
    @IBOutlet weak var navBar: UINavigationItem!
    
    @IBOutlet weak var gripper: UIView!
    
    
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
        
        sender.maximumValue = Double(quantityLabel.text!) ?? 0
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gripper.layer.cornerRadius = 2.5
        
        view.layer.cornerRadius=10
        
        // 1
        view.backgroundColor = .clear
        // 2
        let blurEffect = UIBlurEffect(style: .regular)
    
        // 3
        let blurView = UIVisualEffectView(effect: blurEffect)
        // 4
        blurView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(blurView, at: 0)
        
        NSLayoutConstraint.activate([
            blurView.topAnchor.constraint(equalTo: view.topAnchor),
            blurView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
       

        
    
        foodLabel.text = listing.title
//
        pickUpLocation.text = listing.title
        
        //ActivityIndicator.isHidden = true
        
        //let dataDecoded : Data = Data(base64Encoded: listing.image! , options: .ignoreUnknownCharacters)!
        //let decodedimage = UIImage(data: dataDecoded)
        //foodImageView.image = decodedimage

        
   
        
        foodImageView.layer.borderWidth = 2
        foodImageView.layer.borderColor = UIColor.init(named: "CampusPlateGreen")?.cgColor
        
        foodStopCircleView.backgroundColor = UIColor.init(hexaRGB: foodStopModel.getFoodStop(foodStopId: listing.foodStopId!)!.hexColor)
        claimButton.layer.cornerRadius = 20
        
        let available : Int = listing.quantity ?? 0
        var availableStr = String(available)
        
    
        let unixTimestamp = listing.creationTime
        let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp!))
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm" //Specify your format that you want
        let strDate = dateFormatter.string(from: date)
        
        func daysBetween(start: Date, end: Date) -> Int {
                return Calendar.current.dateComponents([.day], from: start, to: end).day!
        }
        
        let currentDate = Date()
        
        let daysSince = daysBetween(start: date, end: currentDate)
    
        let strDaysSince = String(daysSince)
        
        if strDaysSince == "0" {
            daysPosted.text = "POSTED TODAY"
        }else{
            daysPosted.text = "POSTED " + strDaysSince + " DAYS AGO"
        }
        
        //self.quantityLabel.text = availableStr

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
