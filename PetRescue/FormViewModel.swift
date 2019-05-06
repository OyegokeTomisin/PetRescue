//
//  FormViewModel.swift
//  PetRescue
//
//  Created by OYEGOKE TOMISIN on 29/04/2019.
//  Copyright © 2019 com.OyegokeTomisin. All rights reserved.
//

import Foundation

class FormViewModel: FormValidator {
    
    var form: AdoptionForm?
    var nonValidElements: Set<String>?
    var ruleTargets = [[String]]()
    
    init() {
        form = getFormData()
    }
    
    fileprivate func getFormData() -> AdoptionForm? {
        guard let path = Bundle.main.path(forResource: "pet_adoption-1.json", ofType: "json") else { return nil }
        if let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe){
            let formData = try? JSONDecoder().decode(AdoptionForm.self, from: data)
            return formData
        }
        return nil
    }
    
    func checkItems(for items: Elements) {
        nonValidElements?.insert(items.unique_id)
    }
    
}
