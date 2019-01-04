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

/*struct Rule {
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
}*/
