//
//  NewsCollectionViewCell.swift
//  NewsKit-Demo
//
//  Created by Alex on 12/8/19.
//  Copyright © 2019 NewsKit. All rights reserved.
//

import UIKit

class NewsCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Received
    
    var article: Article?
    
    // MARK: - Outlets
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    
    // MARK: - VC Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
//        article = nil
//        imageView.image = nil
//        titleLbl.text = nil
    }
    
    // MARK: - Setup UI
    
    private func setupUI(){
        // Image View
        guard let article = article else {return}
        // Title Label
        titleLbl.text = article.title
        titleLbl.layer.cornerRadius = 8.0
        titleLbl.clipsToBounds = true
        
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8.0
        imageView.clipsToBounds = true
        
        
    }
}
