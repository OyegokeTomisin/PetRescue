//
//  FormattedNumericTableViewCell.swift
//  PetRescue
//
//  Created by OYEGOKE TOMISIN on 01/01/2019.
//  Copyright © 2019 com.OyegokeTomisin. All rights reserved.
//

import UIKit
import SwiftyJSON

class FormattedNumericTableViewCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var formattedNumericLabel: UILabel!
    @IBOutlet weak var numericTextField: UITextField!
    
    var label: String? { didSet{ formattedNumericLabel.text = label }}
    var formattedNumeric: String?
    var isMandatory: Bool?
    var unique_id:String?
    
    var cellItem: FormattedNumericCellItem?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        numericTextField.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureCell(with element: JSON?){
        guard let element = element else { return }
        label = element["label"].string
        formattedNumeric = element["formattedNumeric"].string
        isMandatory = element["isMandatory"].bool
        unique_id = element["unique_id"].string
    }
}
