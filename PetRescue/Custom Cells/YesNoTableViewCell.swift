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
    
    var element: Elements?{
        didSet{
            yesNoLabel.text = element?.label
        }
    }
    var ruleDelegate: ApplyRule?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func yesNoSwitchControlTapped(_ sender: UISwitch) {
//        let hideCell = false
//        if !sender.isOn{
//           ruleDelegate?.applyRule(cellItem?.rules, with: true)
//        }else{
//
//        }
        if let rule = element?.rules{
            ruleDelegate?.applyRule(rule, with: !sender.isOn)
        }
        
    }
    
//    func applyRules(with hideAction: Bool){
//        guard let rules = cellItem?.rules else { return }
//        for rule in rules{
//            if rule.action == "show"{
//                ruleDelegate?.applyRule(on: rule.targets, with: hideAction)
//            }
//        }
//    }
}
