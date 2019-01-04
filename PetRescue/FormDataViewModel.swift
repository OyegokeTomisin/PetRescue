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
                if element["type"] == "embeddedphoto"{
                    let cellItem = EmbeddedPhotoCellItem()
                    cellItem.element = element
                    Items.append(cellItem)
                }
                if element["type"] == "text"{
                    let cellItem = TextCellItem()
                    cellItem.element = element
                    Items.append(cellItem)
                }
                if element["type"] == "yesno"{
                    let cellItem = YesNoCellItem()
                    cellItem.element = element
                    Items.append(cellItem)
                }
                if element["type"] == "formattednumeric"{
                    let cellItem = FormattedNumericCellItem()
                    cellItem.element = element
                    Items.append(cellItem)
                }
                if element["type"] == "datetime"{
                    let cellItem = DateTimeCellItem()
                    cellItem.element = element
                    Items.append(cellItem)
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
            if let text = formCell as? TextCellItem, let cell = tableView.dequeueReusableCell(withIdentifier: "text") as? TextTableViewCell{
                cell.configureCell(with: text.element)
                return cell
            }
        case .formattednumeric:
            if let formattedNumeric = formCell as? FormattedNumericCellItem, let cell = tableView.dequeueReusableCell(withIdentifier: "formattednumeric") as? FormattedNumericTableViewCell{
                cell.configureCell(with: formattedNumeric.element)
                return cell
            }
        case .yesno:
            if let yesno = formCell as? YesNoCellItem, let cell = tableView.dequeueReusableCell(withIdentifier: "yesno") as? YesNoTableViewCell{
                cell.configureCell(with: yesno.element)
                return cell
            }
        case .datetime:
            if let dateTime = formCell as? DateTimeCellItem, let cell = tableView.dequeueReusableCell(withIdentifier: "datetime") as? DateTimeTableViewCell{
                cell.configureCell(with: dateTime.element)
                return cell
            }
        }
        return UITableViewCell()
    }
}

class TextCellItem:FormViewModelItem{
    var element: JSON?
    var type: FormItemViewModelType{
        return .text
    }
}

class FormattedNumericCellItem:FormViewModelItem{
    var element: JSON?
    var type: FormItemViewModelType{
        return .formattednumeric
    }
}

class DateTimeCellItem:FormViewModelItem{
    var element: JSON?
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
    var element: JSON?
    var type: FormItemViewModelType{
        return .yesno
    }
}
