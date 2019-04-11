//
//  TextTableViewCell.swift
//  PetRescue
//
//  Created by OYEGOKE TOMISIN on 01/01/2019.
//  Copyright © 2019 com.OyegokeTomisin. All rights reserved.
//

import UIKit

class TextTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textCellLabel: UILabel!
    
    var label: String? { didSet{ textCellLabel.text = label }}
    var isMandatory: Bool?
    var unique_id:String?
    var element: Elements?{
        didSet{
            label = element?.label
            isMandatory = element?.isMandatory
            unique_id = element?.unique_id
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        textField.delegate = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        textField.resignFirstResponder()
    }
    
}
