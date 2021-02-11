//
//  FoodListingTableViewCell.swift
//  BWFoodApp
//
//  Created by Brian Krupp on 8/20/18.
//  Copyright © 2018 Dan Fitzgerald. All rights reserved.
//

import UIKit

class FoodListingTableViewCell: UITableViewCell {

    
    @IBOutlet weak var foodLabel: UILabel!
    
    @IBOutlet weak var foodStopLocationLabel: UILabel!
    
    @IBOutlet weak var leftBar: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
