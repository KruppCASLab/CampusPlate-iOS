//
//  DatePickerTableViewCell.swift
//  BWFoodApp
//
//  Created by Dan Fitzgerald on 11/12/18.
//  Copyright © 2018 Dan Fitzgerald. All rights reserved.
//

import UIKit

class DatePickerTableViewCell: UITableViewCell{
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    public var interestedCell:DateChanged?

    @IBAction func valueChanged(_ sender: Any) {
        let date = self.datePicker.date;
        if let interestedCell = interestedCell {
            interestedCell.dateChanged(dateTime: date)
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
