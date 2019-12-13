//
//  MainViewController.swift
//  NewsKit-Demo
//
//  Created by Alex on 12/8/19.
//  Copyright © 2019 NewsKit. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: - Passed
    
    var urlToOpen: URL?

    // MARK: - Properties
    
    var articleLinks: [Article?] = []
    var cacheToCancel: [UICollectionViewCell: DispatchWorkItem] = [:]
    var imageCache: [String: UIImage] = [:]
    
    // MARK: - Instances
    
    private let newsController = NewsController()

    // MARK: - Outlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - VC Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        newsController.begin { (articles) in
            self.articleLinks = articles
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        setupUI()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let browserVC = segue.destination as? BrowserViewController {
             browserVC.receivedLink = urlToOpen
         }
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
        print("count of cell", articleLinks.count)
        return articleLinks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customcell", for: indexPath) as! NewsCollectionViewCell
        
       
        let article = articleLinks[indexPath.item]
        cell.article = article
        if let image = imageCache[article?.title ?? ""] {
            cell.imageView.image = image
        } else {
            if let taskToCancel = cacheToCancel[cell] {
                taskToCancel.cancel()
            }
            if let imageUrl = URL(string: article?.imageUrl ?? "") {
                let workItem = DispatchWorkItem {
                    cell.imageView.downloadImage(from: imageUrl) { (image) in
                        if let title = article?.title {
                            self.imageCache[title] = image
                        }
                    }
                }
                cacheToCancel[cell] = workItem
                
                DispatchQueue.global().async {
                    workItem.perform()
                    
                }
            }
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let link = articleLinks[indexPath.item]?.url
        urlToOpen = link
        performSegue(withIdentifier: "web segue", sender: indexPath)
    }
}
