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
            adoptionFormTable?.reloadData()
        }
    }
    fileprivate let viewModel = FormDataViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureFormTable()
    }
    
    func configureFormTable() {
        
        //adoptionFormTable.delegate = self
        adoptionFormTable.dataSource = viewModel
        adoptionFormTable.tableFooterView = UIView()
        
        adoptionFormTable.register(UINib(nibName: "TextTableViewCell", bundle: nil), forCellReuseIdentifier: "text")
        adoptionFormTable.register(UINib(nibName: "EmbeddedPhotoTableViewCell", bundle: nil), forCellReuseIdentifier: "embeddedPhoto")
        adoptionFormTable.register(UINib(nibName: "YesNoTableViewCell", bundle: nil), forCellReuseIdentifier: "yesno")
        adoptionFormTable.register(UINib(nibName: "FormattedNumericTableViewCell", bundle: nil), forCellReuseIdentifier: "formattednumeric")
        adoptionFormTable.register(UINib(nibName: "DateTimeTableViewCell", bundle: nil), forCellReuseIdentifier: "datetime")
    }
}
