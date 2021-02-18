//
//  PickUpConfirmationViewController.swift
//  BWFoodApp
//
//  Created by Dan Fitzgerald on 2/18/21.
//  Copyright © 2021 Dan Fitzgerald. All rights reserved.
//

import UIKit

class PickUpConfirmationViewController: UIViewController {
    
    @IBOutlet weak var CircleView: UIView!
    @IBOutlet weak var FoodStopLocation: UITextView!
    @IBOutlet weak var FoodStopAddress: UILabel!
    @IBOutlet weak var FoodStopIdNumber: UILabel!
    
    public var foodStop:FoodStop!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        FoodStopLocation.text = foodStop.name
        FoodStopAddress.text = foodStop.streetAddress
        FoodStopIdNumber.text = String(foodStop.foodStopId)
        CircleView.layer.cornerRadius = CircleView.frame.size.width/2
        CircleView.backgroundColor = UIColor.init(hexaRGB: foodStop.hexColor)
        FoodStopIdNumber.textColor = UIColor.init(hexaRGB: foodStop.hexColor)
        
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
