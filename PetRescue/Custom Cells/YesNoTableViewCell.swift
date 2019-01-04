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
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(with element: JSON?){
        guard let element = element else { return }
        yesNoLabel.text = element["label"].string
    }
    
}
