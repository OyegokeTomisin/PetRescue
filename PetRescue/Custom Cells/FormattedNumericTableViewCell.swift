//
//  FormattedNumericTableViewCell.swift
//  PetRescue
//
//  Created by OYEGOKE TOMISIN on 01/01/2019.
//  Copyright © 2019 com.OyegokeTomisin. All rights reserved.
//

import UIKit

class FormattedNumericTableViewCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var formattedNumericLabel: UILabel!
    @IBOutlet weak var numericTextField: UITextField!
    
    var label: String? { didSet{ formattedNumericLabel.text = label }}
    var formattedNumeric: String?
    var isMandatory: Bool?
    var unique_id:String?
    
    var element: Elements?{
        didSet{
            label = element?.label
            formattedNumeric = element?.formattedNumeric
            isMandatory = element?.isMandatory
            unique_id = element?.unique_id
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        numericTextField.delegate = self
         self.addDoneButtonOnKeyboard()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func addDoneButtonOnKeyboard(){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.contentView.frame.width, height: 50))
        doneToolbar.barStyle = .default
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style:.done, target: self, action: #selector(doneButtonAction))
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        self.numericTextField.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction(){
        self.numericTextField.resignFirstResponder()
    }
}
