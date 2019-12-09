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
    
    // MARK: - Properties
    
    var articleLinks: [Article?] = []
    
    // MARK: - Begin
    
    // We return a list of articles
    func begin(completion: @escaping ([Article?]) -> Void){
        scrapeTechmeme { (urlList) in
            var articleList = [Article]()
            let group = DispatchGroup()
            
            for url in urlList {
                group.enter()

                guard let link = url else {continue}
                self.parseArticle(url: link) { (article) in
                    articleList.append(article)
                    group.leave()
                }
            }
            group.notify(queue: .main) {
                self.articleLinks = articleList
                completion(articleList)
            }
        }
    }
    
    // MARK: - Operations
    

    // This is setup to only scrape articles from techmeme.com
    // We return an array of article urls
    func scrapeTechmeme(completion: @escaping ([URL?]) -> Void) {
        do {
            let link = URL(string: "https://www.techmeme.com")
            let html = try String(contentsOf: link!)
            let doc: Document = try SwiftSoup.parse(html)
            let div: Elements = try doc.select("ii")
            let elements = try doc.getAllElements()
            
            var allUrls = [URL?]()
            for element in elements {
                switch element.tagName() {
                case "div" :
                    if try element.className() == "ii" {
                        // We grab the `a href` value within the "ii" div class
                        let url = try? element.select("a").attr("href")
                        
                        // We only pull out real urls
                        if let url = url, url.prefix(4) == "http" {
                            let link = URL(string: url)
                            allUrls.append(link)
                        }
                    }
                default:
                    let _ = 1
                }
            }
            
            print("HERE ALL URLS: ", allUrls.count, allUrls)
            completion(allUrls)
        } catch {
            // contents could not be loaded
            print("Error loading page contents")
            completion([])
        }
    }
    
    private func parseArticle(url: URL, completion: @escaping (Article) -> Void) {
        let articleUrl = url //URL(string: url)!
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

