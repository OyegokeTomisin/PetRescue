//
//  BaseViewController.swift
//  PetRescue
//
//  Created by OYEGOKE TOMISIN on 25/04/2019.
//  Copyright © 2019 com.OyegokeTomisin. All rights reserved.
//

import UIKit

class BaseViewController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [AdoptionFormVC()]
    }
}
