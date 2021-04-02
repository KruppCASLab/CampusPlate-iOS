//
//  MyReservationsTableViewCell.swift
//  BWFoodApp
//
//  Created by Dan Fitzgerald on 3/4/21.
//  Copyright © 2021 Dan Fitzgerald. All rights reserved.
//

import UIKit

class MyReservationsTableViewCell: UITableViewCell {


    @IBOutlet weak var foodStopColor: UIView!
    @IBOutlet weak var foodStopLocation: UITextView!
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var reserved: UILabel!
    @IBOutlet weak var expiresLabel: UILabel!
    
    @IBOutlet weak var reservationCode: UILabel!
    
    
    @IBOutlet weak var foodImageVIew: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
