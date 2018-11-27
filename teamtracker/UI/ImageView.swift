//
//  ImageView.swift
//  teamtracker
//
//  Created by Robby Michels on 29-03-18.
//  Copyright © 2018 Robby Michels. All rights reserved.
//

import Foundation
import UIKit

class ImageView: UIImageView {
    

}

extension UIImageView {
    func roundCornerWithBorder() {
        layer.borderWidth = 1
        layer.masksToBounds = false
        layer.borderColor = UIColor.lightGray.cgColor
        layer.cornerRadius = frame.size.width/2
        clipsToBounds = true
    }
    
    func roundCorner() {
        layer.masksToBounds = false
        layer.cornerRadius = frame.size.width/2
        clipsToBounds = true
    }
    
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}
