//
//  NewsController.swift
//  NewsKit-Demo
//
//  Created by Alex on 12/9/19.
//  Copyright © 2019 NewsKit. All rights reserved.
//

import UIKit
import ReadabilityKit

class NewsController {
    
    func parseArticle(url: String, completion: @escaping (Article) -> Void) {
        let articleUrl = URL(string: url)!
        Readability.parse(url: articleUrl, completion: { data in
            let title = data?.title ?? ""
            let description = data?.description ?? ""
            let keywords = data?.keywords ?? []
            let imageUrl = data?.topImage
            let videoUrl = data?.topVideo
            
            print("title: \(title), keywords \(keywords), top image: \(imageUrl), top video: \(videoUrl)")
            
            let article = Article(title: title, description: description, keywords: keywords, imageUrl: imageUrl, videoUrl: videoUrl)
            completion(article)
            
            DispatchQueue.main.async {
                //self.imageView.downloadImage(from: URL(string: "https://techcrunch.com/wp-content/uploads/2014/02/b0pjcuntzee4hgg07zt84ayv5q37uttg-rr1v3xj2lu.png")!)
//                self.titleLbl.text = title
            }
        })
    }
    
    
}

