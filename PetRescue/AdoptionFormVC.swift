//
//  TextViewController.swift
//  PetRescue
//
//  Created by OYEGOKE TOMISIN on 11/04/2019.
//  Copyright © 2019 com.OyegokeTomisin. All rights reserved.
//

import UIKit

class AdoptionFormVC: UIViewController{
    
    fileprivate var formData: AdoptionForm?
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formData = getFormData()
        collectionView.delegate = self
        collectionView.dataSource = self
        navigationItem.title = formData?.name
        pageControl.numberOfPages = formData?.pages.count ?? 0
    }
    
    fileprivate func getFormData() -> AdoptionForm? {
        guard let path = Bundle.main.path(forResource: "pet_adoption1.json", ofType: "json") else { return nil }
        if let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe){
            let formData = try? JSONDecoder().decode(AdoptionForm.self, from: data)
            return formData }
        return nil
    }
}

extension AdoptionFormVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageControl.currentPage = indexPath.row
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return formData?.pages.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! AdoptionFormCell
        cell.page = formData?.pages[indexPath.row]
        return cell
    }
}

extension AdoptionFormVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: self.view.frame.size.width, height: 567)
    }
}
