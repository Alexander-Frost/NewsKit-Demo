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
    
    // MARK: - Init
    
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
    private func scrapeTechmeme(completion: @escaping ([URL?]) -> Void) {
        do {
            let link = URL(string: "https://www.techmeme.com")
            let html = try String(contentsOf: link!)
            let doc: Document = try SwiftSoup.parse(html)
            let div: Elements = try doc.select("ii")
            let elements = try doc.getAllElements()
            
            var allUrls = [URL?]()
            print("elements", elements.count)
            for element in elements {
                switch element.tagName() {
                case "div" :
                    if try element.className() == "ii" {
                        // We grab the `a href` value within the "ii" div class
                        let url = try? element.select("a").attr("href")
                        
                        // We only pull out real urls
                        if let url = url, url.prefix(5) == "https" {
                            let link = URL(string: url)
                            
                            if !allUrls.contains(link) {
                                allUrls.append(link)
                            }
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
                        
            let article = Article(url: articleUrl, title: title, description: description, keywords: keywords, imageUrl: imageUrl, videoUrl: videoUrl)                
            completion(article)
        })
    }
}

