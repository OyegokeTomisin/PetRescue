//
//  FormDataViewModel.swift
//  PetRescue
//
//  Created by OYEGOKE TOMISIN on 03/01/2019.
//  Copyright © 2019 com.OyegokeTomisin. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

enum FormItemViewModelType {
    case embeddedPhoto
    case text
    case yesno
    case formattednumeric
    case datetime
}

protocol FormViewModelItem {
    var type: FormItemViewModelType { get }
    var uniqueID: String { get }
    var isHidden: Bool { get set }
}

protocol ApplyRule{
    func applyRule(on target: [String], with hideAction: Bool)
}

class FormDataViewModel: NSObject {
    var formItems = [[FormViewModelItem]]()
    var sectionTitles = [String?]()
    var pageIndex: Int = 0 { didSet { loadTableData() } }
    
    override init() {
        super.init()
    }
    
    func loadTableData(){
        guard let formData = parseFileData() else { return }
        let form = FormData(json: formData)
        let sections = form.pages[pageIndex]["sections"].arrayValue
        for section in sections{
            sectionTitles.append(section["label"].string)
            var Items = [FormViewModelItem]()
            for element in section["elements"].arrayValue{
                if let elementType = element["type"].string{
                    switch elementType{
                    case "embeddedphoto":
                        let cellItem = EmbeddedPhotoCellItem(element: element)
                        Items.append(cellItem)
                    case "text":
                        let cellItem = TextCellItem(element: element)
                        Items.append(cellItem)
                    case "yesno":
                        let cellItem = YesNoCellItem(element: element)
                        Items.append(cellItem)
                    case "formattednumeric":
                        let cellItem = FormattedNumericCellItem(element: element)
                        Items.append(cellItem)
                    case "datetime":
                        let cellItem = DateTimeCellItem(element: element)
                        Items.append(cellItem)
                    default:
                        break
                    }
                }
            }
            formItems.append(Items)
            Items = [FormViewModelItem]()
        }
    }
    
    func applyRule(on target: [String], with hideAction: Bool, completion: ()->()){
        for items in formItems{
            for var element in items {
                if target.contains(element.uniqueID) {
                    element.isHidden = hideAction
                }
            }
        }
        completion()
    }
}
