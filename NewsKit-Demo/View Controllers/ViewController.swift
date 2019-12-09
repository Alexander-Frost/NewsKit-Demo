//
//  ViewController.swift
//  NewsKit-Demo
//
//  Created by Alex on 12/8/19.
//  Copyright © 2019 NewsKit. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // DEPRECATED: - Do Not Edit This - Not Used
    
    let identifier = "customcell"
    // MARK: - Outlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.delegate = self
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize =  CGSize(width: collectionView.bounds.size.width/7 * 3 , height:collectionView.bounds.size.width/7 * 3 )
        
        let xib = UINib(nibName: "CollectionViewCell", bundle: nil)
        collectionView.register(xib, forCellWithReuseIdentifier: identifier)
    }


}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: - Collection View
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 90
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! CollectionViewCell
        print("HERE incollection view delegate")
        return cell
    }
    
    
}
