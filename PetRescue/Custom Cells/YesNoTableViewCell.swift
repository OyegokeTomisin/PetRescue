//
//  YesNoTableViewCell.swift
//  PetRescue
//
//  Created by OYEGOKE TOMISIN on 01/01/2019.
//  Copyright © 2019 com.OyegokeTomisin. All rights reserved.
//

import UIKit

class YesNoTableViewCell: UITableViewCell, AdoptionFormElement {
    
    @IBOutlet weak var yesNoLabel: UILabel!
    
    var validationDelegate: ValidateForm?
    var ruleDelegate: ApplyRule?
    var element: Elements?{
        didSet{ yesNoLabel.text = element?.label }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with element: Elements) {
        self.element = element
    }
    
    @IBAction func yesNoSwitchControlTapped(_ sender: UISwitch) {
        if let rule = element?.rules{
            ruleDelegate?.applyRule(rule, with: !sender.isOn)
        }
    }
}
