//
//  NewsCollectionViewCell.swift
//  NewsKit-Demo
//
//  Created by Alex on 12/8/19.
//  Copyright © 2019 NewsKit. All rights reserved.
//

import UIKit

class NewsCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLbl: UILabel!
    
    
    // MARK: - VC Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
    }
    
    // MARK: - Setup UI
    
    private func setupUI(){
        // Image View
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 8.0
        imageView.layer.masksToBounds = true
        
        
    }
}
