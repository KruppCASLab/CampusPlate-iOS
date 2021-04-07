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
    
    @IBOutlet weak var circleView: UIView!
    @IBOutlet weak var foodStopIdNumber: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        FoodStopLocation.textContainer.lineFragmentPadding = 0
        reservationIdNumber.textContainer.lineFragmentPadding = 0
        FoodStopLocation.text = foodStop.name
        FoodStopAddress.text = foodStop.streetAddress
        closeButton.tintColor = UIColor(hexaRGB:foodStop.hexColor)
        foodStopIdNumber.text = String(foodStop.foodStopId)
        circleView.layer.cornerRadius = circleView.frame.size.width/2
        circleView.backgroundColor = UIColor.init(hexaRGB: foodStop.hexColor)
        foodStopIdNumber.textColor = UIColor.init(hexaRGB: foodStop.hexColor)
        
        reservationIdNumber.text = "YOUR RESERVATION NUMBER IS " + String(reservation.code!)
        
    }
    
    
    @IBAction func close(_ sender: Any) {
        if let delegate = presentingDelegate {
            delegate.childViewDidComplete()
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
