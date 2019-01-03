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
}

class FormDataViewModel: NSObject {
    
    var formItems = [[FormViewModelItem]]()
    var sectionTitles = [String?]()
    var pageIndex: Int = 0 {
        didSet{
            loadTableData()
        }
    }
    
    override init() {
        super.init()
    }
    
    func loadTableData(){
        guard let formData = parseJsonData() else { return }
        
        let form = FormData(json: formData)
        let sections = form.pages[pageIndex]["sections"].arrayValue
        for section in sections{
            sectionTitles.append(section["label"].string)
            var Items = [FormViewModelItem]()
            for element in section["elements"].arrayValue{
                if element["type"] == "embeddedphoto"{
                    let emb = EmbeddedPhotoCellItem()
                    emb.element = element
                    Items.append(emb)
                }
                if element["type"] == "text"{
                    let t = TextCellItem()
                    Items.append(t)
                }
                if element["type"] == "yesno"{
                    let y = YesNoCellItem()
                    Items.append(y)
                }
                if element["type"] == "formattednumeric"{
                    let f = FormattedNumericCellItem()
                    Items.append(f)
                }
                if element["type"] == "datetime"{
                    let d = DateTimeCellItem()
                    Items.append(d)
                }
            }
            formItems.append(Items)
            Items = [FormViewModelItem]()
        }
    }
}

extension FormDataViewModel: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return formItems[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return formItems.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let formCell = formItems[indexPath.section][indexPath.row]
        
        switch formCell.type {
        case .embeddedPhoto:
            if let embeddedPhoto = formCell as? EmbeddedPhotoCellItem, let cell = tableView.dequeueReusableCell(withIdentifier: "embeddedPhoto") as? EmbeddedPhotoTableViewCell{
                cell.configureCell(with: embeddedPhoto.element)
                return cell
            }
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
        return UITableViewCell()
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
    var element: JSON?
    var type: FormItemViewModelType{
        return .embeddedPhoto
    }
}

class YesNoCellItem:FormViewModelItem{
    var type: FormItemViewModelType{
        return .yesno
    }
}
