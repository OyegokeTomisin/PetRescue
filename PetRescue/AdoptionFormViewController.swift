//
//  AdoptionFormViewController.swift
//  PetRescue
//
//  Created by OYEGOKE TOMISIN on 31/12/2018.
//  Copyright © 2018 com.OyegokeTomisin. All rights reserved.
//

import UIKit

class AdoptionFormViewController: UIViewController {
    
    var index = 0
    var cell_types = ["embeddedPhoto","text","yesno", "formattednumeric", "datetime", "text"]

    @IBOutlet weak var adoptionFormTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
}

extension AdoptionFormViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // try enum for selecting cell types
        if cell_types[indexPath.row] == "text"{
            let cell = tableView.dequeueReusableCell(withIdentifier: "text") as! TextTableViewCell
            
            return cell
        }
        else if cell_types[indexPath.row] == "embeddedPhoto"{
            let cell = tableView.dequeueReusableCell(withIdentifier: "embeddedPhoto") as! EmbeddedPhotoTableViewCell

            return cell
        }
        else if cell_types[indexPath.row] == "yesno"{
            let cell = tableView.dequeueReusableCell(withIdentifier: "yesno") as! YesNoTableViewCell
            
            return cell
        }
        else if cell_types[indexPath.row] == "formattednumeric"{
            let cell = tableView.dequeueReusableCell(withIdentifier: "formattednumeric") as! FormattedNumericTableViewCell
            
            return cell
        }
        else if cell_types[indexPath.row] == "datetime"{
            let cell = tableView.dequeueReusableCell(withIdentifier: "datetime") as! DateTimeTableViewCell
            
            return cell
        }
        else{
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func configureTableView() {
        
        adoptionFormTable.delegate = self
        adoptionFormTable.dataSource = self
        
        adoptionFormTable.register(UINib(nibName: "TextTableViewCell", bundle: nil), forCellReuseIdentifier: "text")
        adoptionFormTable.register(UINib(nibName: "EmbeddedPhotoTableViewCell", bundle: nil), forCellReuseIdentifier: "embeddedPhoto")
        adoptionFormTable.register(UINib(nibName: "YesNoTableViewCell", bundle: nil), forCellReuseIdentifier: "yesno")
        adoptionFormTable.register(UINib(nibName: "FormattedNumericTableViewCell", bundle: nil), forCellReuseIdentifier: "formattednumeric")
        adoptionFormTable.register(UINib(nibName: "DateTimeTableViewCell", bundle: nil), forCellReuseIdentifier: "datetime")
    }
    
}
