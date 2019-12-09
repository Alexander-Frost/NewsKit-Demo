//
//  NewsController.swift
//  NewsKit-Demo
//
//  Created by Alex on 12/9/19.
//  Copyright © 2019 NewsKit. All rights reserved.
//

import UIKit
import ReadabilityKit
import SwiftSoup

class NewsController {
    
    // MARK: - Begin
    
    func begin(){
        
    }
    
    // MARK: - Operations
    

    
    private func scrapeUrls(url: URL) -> [String]? {
        do {
            let html = try String(contentsOf: url)
            let doc: Document = try SwiftSoup.parse(html)
            let div: Elements = try doc.select("ii") // <div></div>
            let elements = try doc.getAllElements()
            
            var allUrls = [String]()
            for element in elements {
                switch element.tagName() {
                case "div" :
                    if try element.className() == "ii" {
                        // We grab the `a href` value within the "ii" div class
                        let url = try? element.select("a").attr("href")
                        
                        // We only pull out real urls
                        if let url = url, url.prefix(4) == "http" {
                            allUrls.append(url)
                        }
                    }
                default:
                    let _ = 1
                }
            }
            
            print("HERE ALL URLS: ", allUrls.count, allUrls)
//            tempURLs = allUrls
            return allUrls
        } catch {
            // contents could not be loaded
            print("Error loading page contents")
            return nil
        }
        
    }
    
    func extractInfoFromURLs(urls: [String]) {
        for url in urls {
            let articleUrl = URL(string: url)!
            Readability.parse(url: articleUrl, completion: { data in
                let title = data?.title ?? ""
                let description = data?.description ?? ""
                let keywords = data?.keywords ?? []
                let imageUrl = data?.topImage
                let videoUrl = data?.topVideo
                
                print("title: \(title), keywords \(keywords), top image: \(imageUrl), top video: \(videoUrl)")
            })
        }
    }
    
    
    private func parseArticle(url: String, completion: @escaping (Article) -> Void) {
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

