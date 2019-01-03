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
    @IBOutlet weak var nextButton: UIButton!
    
    var formPageViewController: AdoptionFormPageViewController?
    var numberOfPages: Int = 0 {
        didSet{
            formPageControl.numberOfPages = numberOfPages
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        if let index = formPageViewController?.currentIndex {
            switch index {
            case 0...((numberOfPages - 1) - index) :
                formPageViewController?.nextPage()
            default:
                submitForm()
            }
        }
        updateUI()
    }
    
    func submitForm(){
        print("Submitting form")
    }
    
    func updateUI() {
        if let index = formPageViewController?.currentIndex {
            formPageControl.currentPage = index
            switch index {
            case 0...((numberOfPages) - index) :
                nextButton.setTitle("Next", for: .normal)
            default:
                nextButton.setTitle("Submit", for: .normal)
            }
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
