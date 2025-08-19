//
//  ReservationTableViewCell.swift
//  BWFoodApp
//
//  Created by Dan Fitzgerald on 3/4/21.
//  Copyright © 2021 Dan Fitzgerald. All rights reserved.
//

import UIKit

class ReservationTableViewCell: UITableViewCell {

   
    @IBOutlet weak var reservationLabel: UILabel!
    
    @IBOutlet weak var colorIndicator: UIView!
    
    
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
