//
//  YesNoTableViewCell.swift
//  PetRescue
//
//  Created by OYEGOKE TOMISIN on 01/01/2019.
//  Copyright © 2019 com.OyegokeTomisin. All rights reserved.
//

import UIKit

class YesNoTableViewCell: UITableViewCell {

    @IBOutlet weak var yesNoLabel: UILabel!
    
    var ruleDelegate: ApplyRule?
    var element: Elements?{
        didSet{
            yesNoLabel.text = element?.label
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
    
    @IBAction func yesNoSwitchControlTapped(_ sender: UISwitch) {
        if let rule = element?.rules{
            ruleDelegate?.applyRule(rule, with: !sender.isOn)
        }
    }
}
