//
//  FormData.swift
//  PetRescue
//
//  Created by OYEGOKE TOMISIN on 03/01/2019.
//  Copyright © 2019 com.OyegokeTomisin. All rights reserved.
//

import Foundation

protocol AdoptionFormElement{
    var ruleDelegate: ApplyRule? { get set }
    var validationDelegate: ValidateForm? { get set }
    func validateElement()
    func hideElement(_ action: Bool)
    func configure(with element: Elements)
}

extension AdoptionFormElement{
    func validateElement(){ }
    func hideElement(_ action: Bool){ }
}

protocol ApplyRule{
    func applyRule(_ rule: [Rules], with hideAction: Bool)
}

protocol ValidateForm{
    func isValidElement(_ item: Elements)
}

protocol FormValidator {
    func checkItems(for items: Elements)
    //func submitForm()
}

enum Keyboard: String, Decodable{
    case numeric = "numeric"
}

enum Type: String, Decodable{
    case photo = "embeddedphoto"
    case text = "text"
    case yesno = "yesno"
    case formattednumeric = "formattednumeric"
    case datetime = "datetime"
    
    var id: String{
        return self.rawValue
    }
}

struct AdoptionForm: Decodable{
    let id: String
    let name: String
    let pages: [Pages]
}

struct Pages: Decodable{
    let label: String
    let sections: [Section]
}

struct Section: Decodable{
    let label: String
    let elements: [Elements]
}

struct Elements: Decodable {
    let type: Type
    let label: String?
    let isMandatory: Bool?
    
    let file: String?
    let keyboard: Keyboard?
    let formattedNumeric: String?
    let mode: String?
    
    let unique_id: String
    let rules: [Rules]
}

struct Rules: Decodable {
    let condition: String
    let value: String
    let action: String
    let otherwise: String
    let targets: [String]
}
