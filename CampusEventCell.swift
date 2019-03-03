//
//  CampusEventCell.swift
//  BWFoodApp
//
//  Created by Dan Fitzgerald on 2/16/19.
//  Copyright © 2019 Dan Fitzgerald. All rights reserved.
//

import UIKit

class CampusEventCell: UITableViewCell {
    
    @IBOutlet weak var eventTitle: UILabel!
    
    @IBOutlet weak var eventDate: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
