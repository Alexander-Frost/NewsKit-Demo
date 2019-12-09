//
//  MainViewController.swift
//  NewsKit-Demo
//
//  Created by Alex on 12/8/19.
//  Copyright © 2019 NewsKit. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    

    // MARK: - Properties
    
    let foodname = ["club sandwich","burger","pasta","pizza","fries","quadracheetosburger","club sandwich","burger","pasta","pizza","fries","quadracheetosburger"]

    // MARK: - Outlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()



    }
    
    // MARK: - Setup UI
    
    private func setupUI(){
        // Collection View
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // Flow Layout
        let edge:CGFloat = 21.0
        let itemsize = (collectionView.frame.width / 2.5)
        let layout = UICollectionViewFlowLayout()
        
        layout.sectionInset = UIEdgeInsets(top: edge, left: edge, bottom: edge, right: edge)
        layout.itemSize = CGSize(width: itemsize, height: itemsize)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView.collectionViewLayout = layout
        
        
    }

    // MARK: - Collection View
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("HERE running collectionview")
        return foodname.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customcell", for: indexPath) as! NewsCollectionViewCell
        
        cell.titleLbl.text = foodname[indexPath.row]
        cell.imageView.image = UIImage(named: "news")
        return cell
    }
}
