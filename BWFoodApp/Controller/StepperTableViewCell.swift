//
//  StepperTableViewCell.swift
//  BWFoodApp
//
//  Created by Dan Fitzgerald on 3/19/19.
//  Copyright © 2019 Dan Fitzgerald. All rights reserved.
//

import UIKit

class StepperTableViewCell: UITableViewCell {
    
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var quantityValue: UITextField!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
