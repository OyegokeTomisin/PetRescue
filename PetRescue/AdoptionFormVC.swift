//
//  TextViewController.swift
//  PetRescue
//
//  Created by OYEGOKE TOMISIN on 11/04/2019.
//  Copyright © 2019 com.OyegokeTomisin. All rights reserved.
//

import UIKit

class AdoptionFormVC: UIViewController{
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    fileprivate let cellId = "cell"
    fileprivate var viewModel: FormViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = FormViewModel()
        collectionView.delegate = self
        collectionView.dataSource = self
        pageControl.numberOfPages = viewModel?.form?.pages.count ?? 0
        navigationItem.title = viewModel?.form?.name
        collectionView.register(AdoptionFormCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    @objc func submitButtonTapped(_ sender: UIBarButtonItem ){
        NotificationCenter.default.post(name: NSNotification.Name("submit"), object: nil)
        guard let _ = viewModel?.nonValidElements else {
            viewModel?.nonValidElements = Set<String>()
            return
        }
        submitForm()
    }
    
    func submitForm() {
        alert(title: "Yaay!!", errorMessage: "Your form can now be submitted")
    }
    
    func alert(title: String, errorMessage: String?) {
        let alertController = UIAlertController(title: title, message: errorMessage , preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alertController, animated: true) {
            self.viewModel?.nonValidElements = nil
        }
    }
}

extension AdoptionFormVC: FormValidator{
    func checkItems(for cell: Elements) {
        alert(title: "Plesase check this field", errorMessage: cell.label)
    }
}

extension AdoptionFormVC :UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.form?.pages.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AdoptionFormCell
        cell.page = viewModel?.form?.pages[indexPath.row]
        cell.viewModel = viewModel
        cell.formValidator = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageControl.currentPage = indexPath.item
        if let pages = viewModel?.form?.pages{
            if indexPath.row == (pages.count - 1){
                let bar = UIBarButtonItem(title: "Submit", style: .plain, target: self, action: #selector(submitButtonTapped(_:)))
                navigationItem.rightBarButtonItem = bar
            }else{
                navigationItem.rightBarButtonItem = nil
            }
        }
    }
}
