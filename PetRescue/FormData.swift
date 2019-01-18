//
//  FormData.swift
//  PetRescue
//
//  Created by OYEGOKE TOMISIN on 03/01/2019.
//  Copyright © 2019 com.OyegokeTomisin. All rights reserved.
//

import Foundation
import SwiftyJSON

public func parseFileData() -> JSON? {
    if let path = Bundle.main.path(forResource: "pet_adoption-1.json", ofType: "json") {
        if let data = try? Data(contentsOf: URL(fileURLWithPath: path)){
            let json = try? JSON(data: data)
            return json
        }
    }
    return nil
}

class FormData {
    let id: String?
    let name: String?
    let pageTitle: String?
    let pages: JSON
    
    init(json: JSON) {
        self.id = json["id"].string
        self.name = json["name"].string
        self.pageTitle = json["name"].string
        self.pages = json["pages"]
    }
}

class TextCellItem: FormViewModelItem{
    var isHidden: Bool
    var type: FormItemViewModelType{
        return .text
    }
    var uniqueID: String{
        return unique_id!
    }
    
    var label: String?
    var isMandatory: Bool?
    var unique_id:String?
    
    
    init(element: JSON) {
        self.label = element["label"].string
        self.isMandatory = element["isMandatory"].bool
        self.unique_id = element["unique_id"].string
        self.isHidden = false
    }
}

class FormattedNumericCellItem:FormViewModelItem{
    var isHidden: Bool
    
    var uniqueID: String{
        return unique_id!
    }
    
    var label: String?
    var keyboard: String?
    var formattedNumeric: String?
    var isMandatory: Bool?
    var unique_id: String?
    var type: FormItemViewModelType{
        return .formattednumeric
    }
    
    init(element: JSON) {
        self.label = element["label"].string
        self.keyboard = element["keyboard"].string
        self.formattedNumeric = element["formattedNumeric"].string
        self.isMandatory = element["isMandatory"].bool
        self.unique_id = element["unique_id"].string
        self.isHidden = false
    }
}

class DateTimeCellItem:FormViewModelItem{
    var isHidden: Bool
    
    var uniqueID: String{
        return unique_id!
    }
    
    var mode: String?
    var label: String?
    var isMandatory: Bool?
    var unique_id: String?
    var type: FormItemViewModelType{
        return .datetime
    }
    
    init(element: JSON) {
        self.mode = element["mode"].string
        self.label = element["label"].string
        self.isMandatory = element["isMandatory"].bool
        self.unique_id = element["unique_id"].string
        self.isHidden = false
    }
}

class EmbeddedPhotoCellItem:FormViewModelItem{
    var isHidden: Bool
    
    var uniqueID: String{
        return unique_id!
    }
    
    var file: String?
    var unique_id: String?
    var type: FormItemViewModelType{
        return .embeddedPhoto
    }
    
    init(element:JSON) {
        self.file = element["file"].string
        self.unique_id = element["unique_id"].string
        self.isHidden = false
    }
}

class YesNoCellItem:FormViewModelItem{
    var isHidden: Bool
    
    var uniqueID: String{
        return unique_id!
    }
    
    var label: String?
    var isMandatory: Bool?
    var unique_id:String?
    var rules = [Rule]()
    var type: FormItemViewModelType{
        return .yesno
    }
    
    var indexPath: IndexPath?
    
    init(element: JSON) {
        self.isHidden = false
        self.label = element["label"].string
        self.isMandatory = element["isMandatory"].bool
        self.unique_id = element["unique_id"].string
        if let rule = element["rules"].array{
            for values in rule{
                rules.append(Rule(json:values))
            }
        }
    }
}

class Rule {
    let condition: String?
    let value: String?
    let action: String?
    let otherwise: String?
    let targets: [String]?
    
    init(json: JSON) {
        self.condition = json["condition"].string
        self.value = json["value"].string
        self.action = json["action"].string
        self.otherwise = json["otherwise"].string
        self.targets = json["targets"].arrayObject as? [String]
    }
}
