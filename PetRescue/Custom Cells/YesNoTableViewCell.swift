//
//  YesNoTableViewCell.swift
//  PetRescue
//
//  Created by OYEGOKE TOMISIN on 01/01/2019.
//  Copyright © 2019 com.OyegokeTomisin. All rights reserved.
//

import UIKit
import SwiftyJSON

class YesNoTableViewCell: UITableViewCell {

    @IBOutlet weak var yesNoLabel: UILabel!
    
    var cellItem: YesNoCellItem?
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
        let hideCell = false
        if !sender.isOn{
            applyRules(with: !hideCell)
        }else{
            applyRules(with: hideCell)
        }
    }
    
    func applyRules(with hideAction: Bool){
        guard let rules = cellItem?.rules else { return }
        for rule in rules{
            if let shouldShow = rule.action, shouldShow == "show"{
                if let target = rule.targets{
                    ruleDelegate?.applyRule(on: target, with: hideAction)
                }
            }
        }
    }
    
    func configureCell(with element: JSON?){
        guard let element = element else { return }
        yesNoLabel.text = element["label"].string
    }
    
}
