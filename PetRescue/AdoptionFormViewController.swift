//
//  AdoptionFormViewController.swift
//  PetRescue
//
//  Created by OYEGOKE TOMISIN on 31/12/2018.
//  Copyright © 2018 com.OyegokeTomisin. All rights reserved.
//

import UIKit

class AdoptionFormViewController: UIViewController {
    
    @IBOutlet weak var adoptionFormTable: UITableView!
    
    var index = 0{
        didSet{
            viewModel.pageIndex = index
        }
    }
    fileprivate let viewModel = FormDataViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureFormTable()
    }
    
    func configureFormTable() {
        
        //adoptionFormTable.delegate = self
        adoptionFormTable.dataSource = self
        adoptionFormTable.tableFooterView = UIView()
        
        adoptionFormTable.register(UINib(nibName: "TextTableViewCell", bundle: nil), forCellReuseIdentifier: "text")
        adoptionFormTable.register(UINib(nibName: "EmbeddedPhotoTableViewCell", bundle: nil), forCellReuseIdentifier: "embeddedPhoto")
        adoptionFormTable.register(UINib(nibName: "YesNoTableViewCell", bundle: nil), forCellReuseIdentifier: "yesno")
        adoptionFormTable.register(UINib(nibName: "FormattedNumericTableViewCell", bundle: nil), forCellReuseIdentifier: "formattednumeric")
        adoptionFormTable.register(UINib(nibName: "DateTimeTableViewCell", bundle: nil), forCellReuseIdentifier: "datetime")
    }
}

extension AdoptionFormViewController: UITableViewDataSource, UITableViewDelegate, ApplyRule{
    func applyRule(on target: [String], with hideAction: Bool) {
        viewModel.applyRule(on: target, with: hideAction){
            self.adoptionFormTable.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.formItems[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.formItems.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let form = viewModel.formItems[indexPath.section][indexPath.row]
        
        switch form.type {
        case .embeddedPhoto:
            if let embeddedPhoto = form as? EmbeddedPhotoCellItem, let cell = tableView.dequeueReusableCell(withIdentifier: "embeddedPhoto") as? EmbeddedPhotoTableViewCell{
                cell.cellItem = embeddedPhoto
                cell.isHidden = embeddedPhoto.isHidden
                return cell
            }
        case .text:
            if let text = form as? TextCellItem, let cell = tableView.dequeueReusableCell(withIdentifier: "text") as? TextTableViewCell{
                cell.cellItem = text
                cell.isHidden = text.isHidden
                return cell
            }
        case .formattednumeric:
            if let formattedNumeric = form as? FormattedNumericCellItem, let cell = tableView.dequeueReusableCell(withIdentifier: "formattednumeric") as? FormattedNumericTableViewCell{
                cell.cellItem = formattedNumeric
                cell.isHidden = formattedNumeric.isHidden
                return cell
            }
        case .yesno:
            if let yesno = form as? YesNoCellItem, let cell = tableView.dequeueReusableCell(withIdentifier: "yesno") as? YesNoTableViewCell{
                cell.cellItem = yesno
                cell.isHidden = yesno.isHidden
                cell.ruleDelegate = self
                return cell
            }
        case .datetime:
            if let dateTime = form as? DateTimeCellItem, let cell = tableView.dequeueReusableCell(withIdentifier: "datetime") as? DateTimeTableViewCell{
                cell.cellItem = dateTime
                cell.isHidden = dateTime.isHidden
                return cell
            }
        }
        return UITableViewCell()
    }
}
