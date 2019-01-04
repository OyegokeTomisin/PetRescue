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
    var pageTitle: String { get set }
}

class AdoptionFormPageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {

    weak var formDelegate: AdoptionFormPageViewControllerDelegate?
    var currentIndex = 0
    var pagesCount: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        delegate = self
        dataSource = self
    
        guard let formData = parseFileData() else { return }
        let form = FormData(json: formData)
        if let number_of_pages = form.pages.array{
            pagesCount = number_of_pages.count
            formDelegate?.numberOfPages = pagesCount ?? 0
            formDelegate?.pageTitle = form.pageTitle ?? "Adoption Form"
        }
        
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
        if index < 0 || index >= pagesCount ?? 0 {
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
    func nextPage() {
        currentIndex += 1
        if let nextViewController = contentViewController(at: currentIndex) {
            setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    func previousPage() {
        currentIndex -= 1
        if let nextViewController = contentViewController(at: currentIndex) {
            setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            if let contentViewController = pageViewController.viewControllers?.first as? AdoptionFormViewController {
                currentIndex = contentViewController.index
                formDelegate?.didUpdatePageIndex(currentIndex: currentIndex)
            }
        }
    }
}
