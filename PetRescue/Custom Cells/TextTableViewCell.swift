//
//  TextTableViewCell.swift
//  PetRescue
//
//  Created by OYEGOKE TOMISIN on 01/01/2019.
//  Copyright © 2019 com.OyegokeTomisin. All rights reserved.
//

import UIKit

class TextTableViewCell: UITableViewCell, UITextFieldDelegate, AdoptionFormElement {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textCellLabel: UILabel!
    
    var ruleDelegate: ApplyRule?
    var validationDelegate: ValidateForm?{
        didSet{ validateElement() }
    }
    var element: Elements?{
        didSet{ textCellLabel.text = element?.label }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textField.delegate = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with element: Elements) {
        self.element = element
    }
    
    func hideElement(_ hideAction: Bool) {
        self.isHidden = hideAction
    }
    
    func validateElement(){
        if element?.isMandatory ?? true{
            if (textField.text == nil || textField.text?.isEmpty ?? true){
                validationDelegate?.isValidElement(element!)
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        textField.resignFirstResponder()
    }
    
}
