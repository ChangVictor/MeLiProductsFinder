//
//  CustomImageView.swift
//  MeLiProductsFinder
//
//  Created by Victor Chang on 24/10/2019.
//  Copyright © 2019 Victor Chang. All rights reserved.
//

import UIKit

var imageCache = [String: UIImage]()

class CustomImageView: UIImageView {
    var lastUrlUsedToLoadImage: String?
    
    func loadImage(fromUrl: String) {
        lastUrlUsedToLoadImage = fromUrl
        
        self.image = nil
        
        if let cachedImage = imageCache[fromUrl] {
            self.image = cachedImage
            return
        }
        
        guard let url = URL(string: fromUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Failed to fetch image: ", error)
                return
            }
            
            if url.absoluteString != self.lastUrlUsedToLoadImage {
                return
            }
            
            guard let imageData = data else { return }
            let photoImage = UIImage(data: imageData)
            imageCache[url.absoluteString] = photoImage
            
            DispatchQueue.main.async {
                self.image = photoImage
            }
        }
        .resume()
    }
}
