//
//  DateTimeTableViewCell.swift
//  PetRescue
//
//  Created by OYEGOKE TOMISIN on 01/01/2019.
//  Copyright © 2019 com.OyegokeTomisin. All rights reserved.
//

import UIKit

class DateTimeTableViewCell: UITableViewCell {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var selectedDateLabel: UILabel!
    
    var element: Elements?{
        didSet{
            dateTimeLabel.text = element?.label
        }
    }
    
    var dateOfBirth: String?{
        didSet{
            selectedDateLabel.text = dateOfBirth
            selectedDateLabel.isHidden = false
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectedDateLabel.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func selectDateAction(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let selectedDate = formatter.string(from: sender.date)
        dateOfBirth = selectedDate
    }
}
