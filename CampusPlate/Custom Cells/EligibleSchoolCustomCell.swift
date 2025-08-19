//
//  EligibleSchoolCustomCell.swift
//  BWFoodApp
//
//  Created by Dan Fitzgerald on 2/3/19.
//  Copyright © 2019 Dan Fitzgerald. All rights reserved.
//

import UIKit

class EligibleSchoolCustomCell: UITableViewCell {
    
    
    @IBOutlet weak var eligibleSchoolLocation: UILabel!
    @IBOutlet weak var eligibleSchoolTitle: UILabel!
    @IBOutlet weak var eligibleSchoolImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
