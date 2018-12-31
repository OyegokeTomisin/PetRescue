//
//  AdoptionFormPageViewController.swift
//  PetRescue
//
//  Created by OYEGOKE TOMISIN on 31/12/2018.
//  Copyright © 2018 com.OyegokeTomisin. All rights reserved.
//

import UIKit

protocol AdoptionFormPageViewControllerDelegate: class {
    func didUpdatePageIndex(currentIndex: Int)
    var numberOfPages: Int { get set }
}

class AdoptionFormPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    weak var formDelegate: AdoptionFormPageViewControllerDelegate?
    var currentIndex = 0
    var pages = [1,2,3]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        delegate = self
        
        formDelegate?.numberOfPages = pages.count
        
        if let startingViewController = contentViewController(at: 0) {
            setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! AdoptionFormViewController).index
        index -= 1
        
        return contentViewController(at: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! AdoptionFormViewController).index
        index += 1
        return contentViewController(at: index)
    }
    
    func contentViewController(at index: Int) -> AdoptionFormViewController? {
        if index < 0 || index >= pages.count {
            return nil
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let pageContentViewController = storyboard.instantiateViewController(withIdentifier: "FormContent") as? AdoptionFormViewController {
            pageContentViewController.index = index
            
            return pageContentViewController
        }
        return nil
    }
    
    //Add skip to next page function
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            if let contentViewController = pageViewController.viewControllers?.first as? AdoptionFormViewController {
                currentIndex = contentViewController.index
                formDelegate?.didUpdatePageIndex(currentIndex: currentIndex)
            }
        }
    }
}
