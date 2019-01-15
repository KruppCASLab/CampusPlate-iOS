//
//  UIContactClassTableViewCell.swift
//  BWFoodApp
//
//  Created by Dan Fitzgerald on 1/8/19.
//  Copyright © 2019 Dan Fitzgerald. All rights reserved.
//

import UIKit

class UIContactClassTableViewCell: UITableViewCell {
    
    @IBOutlet weak var foodInputLabel: UITextField!
    @IBOutlet weak var locationInputLabel: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
