//
//  CameraCell.swift
//  BWFoodApp
//
//  Created by Dan Fitzgerald on 7/13/19.
//  Copyright © 2019 Dan Fitzgerald. All rights reserved.
//

import UIKit

class CameraCell: UITableViewCell {
    
    @IBOutlet weak var FoodImage: UIImageView!
    @IBOutlet weak var TakePicture: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
