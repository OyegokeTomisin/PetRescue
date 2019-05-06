//
//  DateTimeTableViewCell.swift
//  PetRescue
//
//  Created by OYEGOKE TOMISIN on 01/01/2019.
//  Copyright © 2019 com.OyegokeTomisin. All rights reserved.
//

import UIKit

class DateTimeTableViewCell: UITableViewCell, AdoptionFormElement {
    
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var selectedDateLabel: UILabel!
    
    var ruleDelegate: ApplyRule?
    var validationDelegate: ValidateForm?{
        didSet{ validateElement() }
    }
    var element: Elements?{
        didSet{ dateTimeLabel.text = element?.label }
    }
    var dateOfBirth: String?{
        didSet{
            selectedDateLabel.text = dateOfBirth
            selectedDateLabel.isHidden = false
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectedDateLabel.isHidden = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with element: Elements) {
        self.element = element
    }
    
    func validateElement(){
        if dateOfBirth == nil && element?.isMandatory ?? true {
            validationDelegate?.isValidElement(element!)
        }
    }
    
    @IBAction func selectDateAction(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let selectedDate = formatter.string(from: sender.date)
        dateOfBirth = selectedDate
    }
}
