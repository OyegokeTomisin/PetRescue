//
//  FormDataViewModel.swift
//  PetRescue
//
//  Created by OYEGOKE TOMISIN on 03/01/2019.
//  Copyright © 2019 com.OyegokeTomisin. All rights reserved.
//

import Foundation
import UIKit

enum FormItemViewModelType {
    case embeddedPhoto
    case text
    case yesno
    case formattednumeric
    case datetime
}

protocol FormViewModelItem {
    var type: FormItemViewModelType { get }
}

class FormDataViewModel: NSObject {
    
    var formItems = [FormViewModelItem]()
    var sectionCount: Int = 1
    
    override init() {
        super.init()
        guard let formData = parseJsonData() else { return }
        
        let form = FormData(json: formData)
        let sections = form.pages[0]["sections"].arrayValue
        for section in sections{
            sectionCount = sections.count
            //print(sectionCount)
            for element in section["elements"].arrayValue{
                if element["type"] == "embeddedphoto"{
                    let emb = EmbeddedPhotoCellItem()
                    formItems.append(emb)
                }
                if element["type"] == "text"{
                    let t = TextCellItem()
                    formItems.append(t)
                }
                if element["type"] == "yesno"{
                    let y = YesNoCellItem()
                    formItems.append(y)
                }
                if element["type"] == "formattednumeric"{
                    let f = FormattedNumericCellItem()
                    formItems.append(f)
                }
                if element["type"] == "datetime"{
                    let d = DateTimeCellItem()
                    formItems.append(d)
                }
            }
            print(formItems)
        }
    }
}

extension FormDataViewModel: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return formItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = formItems[indexPath.row]
        switch item.type {
            
        case .embeddedPhoto:
            let cell = tableView.dequeueReusableCell(withIdentifier: "embeddedPhoto") as! EmbeddedPhotoTableViewCell
            
            return cell
        case .text:
            let cell = tableView.dequeueReusableCell(withIdentifier: "text") as! TextTableViewCell
            
            return cell
        case .datetime:
            let cell = tableView.dequeueReusableCell(withIdentifier: "datetime") as! DateTimeTableViewCell
            
            return cell
        case .formattednumeric:
            let cell = tableView.dequeueReusableCell(withIdentifier: "formattednumeric") as! FormattedNumericTableViewCell
            
            return cell
        case .yesno:
            let cell = tableView.dequeueReusableCell(withIdentifier: "yesno") as! YesNoTableViewCell
            
            return cell
        }
    }
}

class TextCellItem:FormViewModelItem{
    var type: FormItemViewModelType{
        return .text
    }
}

class FormattedNumericCellItem:FormViewModelItem{
    var type: FormItemViewModelType{
        return .formattednumeric
    }
}

class DateTimeCellItem:FormViewModelItem{
    var type: FormItemViewModelType{
        return .datetime
    }
}

class EmbeddedPhotoCellItem:FormViewModelItem{
    var type: FormItemViewModelType{
        return .embeddedPhoto
    }
}

class YesNoCellItem:FormViewModelItem{
    var type: FormItemViewModelType{
        return .yesno
    }
}
