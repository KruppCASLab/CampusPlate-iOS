//
//  PickUpConfirmationViewController.swift
//  BWFoodApp
//
//  Created by Dan Fitzgerald on 2/18/21.
//  Copyright © 2021 Dan Fitzgerald. All rights reserved.
//

import UIKit

class PickUpConfirmationViewController: UIViewController {
    public var presentingDelegate:PresentingViewControllerDelegate?
   
    @IBOutlet weak var FoodStopLocation: UITextView!
    @IBOutlet weak var FoodStopAddress: UILabel!
    
    
    @IBOutlet weak var reservationIdNumber: UITextView!

    public var reservation: Reservation!
    public var foodStop:FoodStop!
    @IBOutlet weak var closeButton: UIButton!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        FoodStopLocation.textContainer.lineFragmentPadding = 0
        reservationIdNumber.textContainer.lineFragmentPadding = 0
        FoodStopLocation.text = foodStop.name
        FoodStopAddress.text = foodStop.streetAddress
        closeButton.tintColor = UIColor(hexaRGB:foodStop.hexColor)
//        FoodStopIdNumber.text = String(foodStop.foodStopId)
//        CircleView.layer.cornerRadius = CircleView.frame.size.width/2
//        CircleView.backgroundColor = UIColor.init(hexaRGB: foodStop.hexColor)
//        FoodStopIdNumber.textColor = UIColor.init(hexaRGB: foodStop.hexColor)
        
        reservationIdNumber.text = "YOUR RESERVATION NUMBER IS " + String(reservation.code!)
        
    }
    
    
    @IBAction func close(_ sender: Any) {
        if let delegate = presentingDelegate {
            delegate.childViewDidComplete()
        }
    }
    
    
    @IBAction func goToMap(_ sender: Any) {
//        let vc = MyReservationsTableViewController(nibName: "MyReservationsTableViewController", bundle: nil)
//        vc.listing = listing
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
