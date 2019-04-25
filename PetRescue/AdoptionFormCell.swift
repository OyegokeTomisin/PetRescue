//
//  TestCollectionViewCell.swift
//  PetRescue
//
//  Created by OYEGOKE TOMISIN on 11/04/2019.
//  Copyright © 2019 com.OyegokeTomisin. All rights reserved.
//

import UIKit

class AdoptionFormCell: UICollectionViewCell {
    
    var page: Pages?
    fileprivate  var ruleTargets = [[String]]()
    fileprivate let cells = [
        (name: "TextTableViewCell", id: "text"),
        (name: "YesNoTableViewCell", id: "yesno"),
        (name: "DateTimeTableViewCell", id: "datetime"),
        (name: "EmbeddedPhotoTableViewCell", id: "embeddedPhoto"),
        (name: "FormattedNumericTableViewCell", id: "formattednumeric") ]
    
    fileprivate var formTable: UITableView! = {
        let tab = UITableView()
        tab.estimatedRowHeight = 100
        return tab
    }()
    
    override func layoutSubviews() {
        addSubview(formTable)
        formTable.delegate = self
        formTable.dataSource = self
        formTable.tableFooterView = UIView()
        formTable.frame = self.contentView.frame
        cells.forEach({ formTable.register(UINib(nibName: $0.name, bundle: nil), forCellReuseIdentifier: $0.id)})
    }
}

extension AdoptionFormCell: ApplyRule {
    func applyRule(_ rule: [Rules], with hideAction: Bool) {
        hideAction ? rule.forEach({ (ruleTargets.append($0.targets)) }) : (ruleTargets = [[String]]())
        formTable.reloadData()
    }
}

extension AdoptionFormCell: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return page?.sections[section].elements.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return page?.sections[section].label
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return page?.sections.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let formElement = page?.sections[indexPath.section].elements[indexPath.row]{
            
            switch formElement.type {
            case .text:
                if let cell = tableView.dequeueReusableCell(withIdentifier: cells[0].id) as? TextTableViewCell{
                    cell.element = formElement
                    ruleTargets.forEach({ cell.isHidden = $0.contains(formElement.unique_id) })
                    return cell
                }
            case .yesno:
                if let cell = tableView.dequeueReusableCell(withIdentifier: cells[1].id) as? YesNoTableViewCell{
                    cell.element = formElement
                    cell.ruleDelegate = self
                    return cell
                }
            case .datetime:
                if let cell = tableView.dequeueReusableCell(withIdentifier: cells[2].id) as? DateTimeTableViewCell{
                    cell.element = formElement
                    return cell
                }
            case .photo:
                if let cell = tableView.dequeueReusableCell(withIdentifier: cells[3].id) as? EmbeddedPhotoTableViewCell{
                    cell.element = formElement
                    return cell
                }
                
            case .formattednumeric:
                if let cell = tableView.dequeueReusableCell(withIdentifier: cells[4].id) as? FormattedNumericTableViewCell{
                    cell.element = formElement
                    return cell
                }
            }
        }
        return UITableViewCell()
    }
}
