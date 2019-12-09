//
//  Extensions.swift
//  NewsKit-Demo
//
//  Created by Alex on 12/9/19.
//  Copyright © 2019 NewsKit. All rights reserved.
//

import UIKit

extension UIImageView {
    func downloadImage(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse,
//                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return print("HERE PROBLEM")}
            DispatchQueue.main.async() {
                print("Image data: ", data, image)
                self.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        guard let url = URL(string: link) else { return }
        downloadImage(from: url, contentMode: mode)
    }
}
