//
//  ShowTimeCell.swift
//  BWFoodApp
//
//  Created by Dan Fitzgerald on 11/4/18.
//  Copyright © 2018 Dan Fitzgerald. All rights reserved.
//

import UIKit

class ShowTimeCell: UITableViewCell, DateChanged {
    
  
    @IBOutlet weak var showTimeLabel: UILabel!
    
    
    
    func dateChanged(dateTime: Date) {
        let timeFormatter = DateFormatter()
        
        timeFormatter.timeStyle = DateFormatter.Style.short
        
        let strDate = timeFormatter.string(from: dateTime)
        DispatchQueue.main.async {
            self.showTimeLabel.text = strDate
        }
        
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
