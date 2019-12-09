//
//  BrowserViewController.swift
//  NewsKit-Demo
//
//  Created by Alex on 12/9/19.
//  Copyright © 2019 NewsKit. All rights reserved.
//

import UIKit
import WebKit

class BrowserViewController: UIViewController, WKNavigationDelegate {

    // MARK: - Received Properties
    
    var receivedLink: URL?
    
    // MARK: - Instances
    
    private let newsController = NewsController()
    
    // MARK: - Outlets
    
    @IBOutlet weak var webView: WKWebView!
    
    // MARK: - VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        if let receivedLink = receivedLink {
            openWebsite(url: receivedLink)
        } else {print("HERE ERROR loading page")}
    }
    
    // MARK: - Setup UI

    private func setupUI(){
        // Webview
        webView.navigationDelegate = self
    }
    
    // MARK: - Operations
    
    private func openWebsite(url: URL){
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
           print("Finished navigating to url \(webView.url)")
    }
}
