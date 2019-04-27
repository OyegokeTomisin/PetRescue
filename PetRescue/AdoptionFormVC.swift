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
    fileprivate var formData: AdoptionForm?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formData = getFormData()
        collectionView.delegate = self
        collectionView.dataSource = self
        navigationItem.title = formData?.name
        collectionView.register(AdoptionFormCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    fileprivate func getFormData() -> AdoptionForm? {
        guard let path = Bundle.main.path(forResource: "pet_adoption-1.json", ofType: "json") else { return nil }
        if let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe){
            let formData = try? JSONDecoder().decode(AdoptionForm.self, from: data)
            return formData
        }
        return nil
    }
    
    @objc func submitButtonTapped(_ sender: UIBarButtonItem ){
        NotificationCenter.default.post(name: NSNotification.Name("submit"), object: nil)
    
    }
    
    func alert(title: String, errorMessage: String?) {
        let alertController = UIAlertController(title: title, message: errorMessage , preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}

extension AdoptionFormVC: FormValidator{
    func submitForm() {
        alert(title: "Yaay!!", errorMessage: "Your form can now be submitted")
    }
    
    func checkItems(for cell: Elements) {        
        alert(title: "Plesase check this field", errorMessage: cell.label)
    }
}

extension AdoptionFormVC :UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return formData?.pages.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AdoptionFormCell
        cell.page = formData?.pages[indexPath.row]
        cell.formValidator = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageControl.currentPage = indexPath.item
        if let pages = formData?.pages{
            if indexPath.row == (pages.count - 1){
                let bar = UIBarButtonItem(title: "Submit", style: .plain, target: self, action: #selector(submitButtonTapped(_:)))
                navigationItem.rightBarButtonItem = bar
            }else{
                navigationItem.rightBarButtonItem = nil
            }
        }
    }
}
