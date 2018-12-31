//
//  AdoptionFormRootViewController.swift
//  PetRescue
//
//  Created by OYEGOKE TOMISIN on 31/12/2018.
//  Copyright © 2018 com.OyegokeTomisin. All rights reserved.
//

import UIKit

class AdoptionFormRootViewController: UIViewController, AdoptionFormPageViewControllerDelegate {

    @IBOutlet weak var formPageControl: UIPageControl!
    
    var formPageViewController: AdoptionFormPageViewController?
    var numberOfPages: Int = 0 {
        didSet{
            formPageControl.numberOfPages = numberOfPages
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func updateUI() {
        if let index = formPageViewController?.currentIndex {
            formPageControl.currentPage = index
        }
    }
    
    func didUpdatePageIndex(currentIndex: Int) {
        updateUI()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination
        if let pageViewController = destination as? AdoptionFormPageViewController {
            formPageViewController = pageViewController
            formPageViewController?.formDelegate = self
        }
    }
}
