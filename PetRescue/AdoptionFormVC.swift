//
//  TextViewController.swift
//  PetRescue
//
//  Created by OYEGOKE TOMISIN on 11/04/2019.
//  Copyright © 2019 com.OyegokeTomisin. All rights reserved.
//

import UIKit

class AdoptionFormVC: UICollectionViewController, UICollectionViewDelegateFlowLayout{
    
    fileprivate let cellId = "cell"
    fileprivate var formData: AdoptionForm?
    
    fileprivate let bar = UIBarButtonItem(title: "Submit", style: .plain, target: self, action: #selector(submit))
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 80, left: 0, bottom: 0, right: 0)
        layout.invalidateLayout()
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formData = getFormData()
        navigationItem.title = formData?.name
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .white
        collectionView.register(AdoptionFormCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    @objc func submit(){
        
    }
    
    fileprivate func getFormData() -> AdoptionForm? {
        guard let path = Bundle.main.path(forResource: "pet_adoption-1.json", ofType: "json") else { return nil }
        if let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe){
            let formData = try? JSONDecoder().decode(AdoptionForm.self, from: data)
            return formData
        }
        return nil
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AdoptionFormCell
        cell.page = formData?.pages[indexPath.row]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return formData?.pages.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.frame.width, height: collectionView.frame.height - 50)
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let pages = formData?.pages{
            if indexPath.row == (pages.count - 1){
                navigationItem.rightBarButtonItem = bar
            }else{
                navigationItem.rightBarButtonItem = nil
            }
        }
    }
}
