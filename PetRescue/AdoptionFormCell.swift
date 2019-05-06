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
    var shouldValidate = false
    var viewModel: FormViewModel?
    var formValidator: FormValidator?
    
    fileprivate let cells = [
        (name: "TextTableViewCell", id: "text"),
        (name: "YesNoTableViewCell", id: "yesno"),
        (name: "DateTimeTableViewCell", id: "datetime"),
        (name: "EmbeddedPhotoTableViewCell", id: "embeddedphoto"),
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
        NotificationCenter.default.addObserver(self, selector: #selector(submitButtonTapped), name: NSNotification.Name("submit"), object: nil)
    }
    
    @objc func submitButtonTapped(){
        shouldValidate = true
        formTable.reloadData()
    }
}

extension AdoptionFormCell: ApplyRule, ValidateForm {
    func isValidElement(_ item: Elements) {
//        viewModel?.checkItems(for: item)
//        viewModel?.nonValidElements?.insert(item.unique_id)
    }
    
    func applyRule(_ rule: [Rules], with hideAction: Bool) {
        hideAction ? rule.forEach({ (viewModel?.ruleTargets.append($0.targets)) }) : (viewModel?.ruleTargets = [[String]]())
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
            var cell = tableView.dequeueReusableCell(withIdentifier: formElement.type.id, for: indexPath) as! AdoptionFormElement
            cell.configure(with: formElement)
            viewModel?.ruleTargets.forEach({ cell.hideElement($0.contains(formElement.unique_id))})
            shouldValidate ? (cell.validationDelegate = self) : nil
            cell.ruleDelegate = self
            return cell as! UITableViewCell
        }
        return UITableViewCell()
    }
}
