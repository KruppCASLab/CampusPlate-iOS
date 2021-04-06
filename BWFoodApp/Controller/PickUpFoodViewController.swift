//
//  pickUpFoodViewController.swift
//  BWFoodApp
//
//  Created by Dan Fitzgerald on 8/3/18.
//  Copyright © 2018 Dan Fitzgerald. All rights reserved.
//

import UIKit
import CoreGraphics

class PickUpFoodViewController: UIViewController, PresentingViewControllerDelegate {
    
    
    let listingModel = ListingModel.getSharedInstance()
    let foodStopModel = FoodStopModel.getSharedInstance()
    let reservationModel = ReservationModel.getSharedInstance()
    
    public var delegate:CreateNewListingDelegate?
    public var presentingDelegate:PresentingViewControllerDelegate?
    
    @IBOutlet weak var navBar: UINavigationItem!
    
    @IBOutlet weak var daysPosted: UILabel!
    
    @IBOutlet weak var colorIndicator: UIView!
    @IBOutlet weak var pickUpLocation: UILabel!
    @IBOutlet weak var pickUpLocationAddress: UILabel!
    @IBOutlet weak var foodStopCircleView: UIView!
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var foodDescription: UITextView!
    @IBOutlet weak var quantityLabel: UILabel!
    
    public var listing:Listing!
    public var createdReservation:Reservation!
    private var quantitySelected:Int = 1
    
    public var indexPathOfListing:IndexPath!
    
    public var foodStop:FoodStop!
    
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var pickUpButton: UIBarButtonItem!
    
    
    @IBOutlet weak var stepper: UIStepper!
    
    func childViewDidComplete() {
        if let presentingDelegate = presentingDelegate {
            presentingDelegate.childViewDidComplete()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //        let width:CGFloat = UIScreen.main.bounds.width*0.0533
        //        colorIndicator.frame = CGRect(x: 0,y: 0,width: width,height: width)
        //        colorIndicator.layer.masksToBounds = true
        //        colorIndicator.layer.cornerRadius = width/2
        
        foodDescription.textContainer.lineFragmentPadding = 0
        
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
        
        
        foodStop = foodStopModel.getFoodStop(foodStopId: listing.foodStopId!)!
        
        pickUpButton.tintColor = UIColor(hexaRGB: foodStop.hexColor)
        cancelButton.tintColor = UIColor(hexaRGB: foodStop.hexColor)
        
        navBar.title = listing.title
        
        foodDescription.text = listing.description
        pickUpLocation.text = foodStop.name
        quantityLabel.text = "1/" + String(listing.quantityRemaining!)
        pickUpLocationAddress.text = foodStop.streetAddress
        
        stepper.maximumValue = Double(listing.quantityRemaining!)
        
        foodStopCircleView.backgroundColor = UIColor.init(hexaRGB: foodStop.hexColor)
        
        listingModel.getImage(listingId: listing.listingId!) { (data) in
            
            DispatchQueue.main.async {
                if !data.isEmpty{
                    var decodedImage = UIImage(data: data)
                    self.foodImageView.image = decodedImage
                }else{
                    self.foodImageView.image = UIImage(named: "spoony.png")
                }
                
            }
            
        }
        
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
        }else if strDaysSince == "1" {
            daysPosted.text = "POSTED " + strDaysSince + " DAY AGO"
        }else{
            daysPosted.text = "POSTED " + strDaysSince + " DAYS AGO"
        }
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pickUpButton(_ sender: Any) {
        
        // This should not be reached, but in case it is, make sure we handle it
        guard quantitySelected > 0 else {
            let alert = UIAlertController(title: "Error", message: "Please select a quantity to reserve", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        pickUpButton.isEnabled = false
        
        let reservation = Reservation(listingId: listing.listingId!, quantity: quantitySelected)
        
        reservationModel.addReservation(reservation: reservation) { [self] (ReservationResponse) in
            if (ReservationResponse.status == 1) {
                let alert = UIAlertController(title: "Quantity Not Available", message: "The quantity you selected was not available for pick up, please select a lesser quantity.", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (completed) in
                    self.pickUpButton.isEnabled = true
                }))
                
                        
                DispatchQueue.main.async {
                    self.present(alert, animated: true, completion: nil)
                }
                
            }
            else if (ReservationResponse.status == 2) {
                let alert = UIAlertController(title: listing.title! + " is no longer available.", message: "The listing you have selected, is no longer available for pick up.", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (completed) in
                    self.dismiss(animated: true, completion: nil)
                }))
                
                        
                DispatchQueue.main.async {
                    self.present(alert, animated: true, completion: nil)
                }
                
            }
            else {
                DispatchQueue.main.async { [self] in
                    //let vc = MyReservationsTableViewController(nibName: "MyReservationsTableViewController", bundle: nil)
                    //vc.listing = listing
                    createdReservation = ReservationResponse.data
                    self.performSegue(withIdentifier: "pickUpConfirmation", sender: self)
                }
            }
            
        }
        
        
    }
    
    
    
    
    @IBAction func stepper(_ sender: UIStepper) {
        
        quantityLabel.text = Int(sender.value).description + "/" + String(listing.quantityRemaining!)
        
        quantitySelected = Int(sender.value)
    }
    
    
    
    
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return false
    }
    
    
    
    
    //     MARK: - Navigation
    //
    //     In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "pickUpConfirmation") {
            if let vc = segue.destination as? PickUpConfirmationViewController {
                vc.presentingDelegate = self
                vc.foodStop = foodStop
                vc.reservation = createdReservation
            }
        }
    }
}



