//
//  PhotoCell.swift
//  Image Gallery
//
//  Created by Balkrishna Choudhary on 30/09/24.
//

import UIKit

class ImageCache {
    static let shared = NSCache<NSString, UIImage>()
}

class PhotoCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    func configure(with photo: Photo) {
        titleLabel.text = photo.title
        loadImage(from: photo.thumbnailUrl)
    }
    
    private func loadImage(from url: String) {
        if let cachedImage = ImageCache.shared.object(forKey: url as NSString) {
            imageView.image = cachedImage
            return
        }
        
        guard let imageURL = URL(string: url) else {
            showPlaceholderImage()
            return
        }
        
        URLSession.shared.dataTask(with: imageURL) { [weak self] data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self?.showPlaceholderImage()
                }
                return
            }
            
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    ImageCache.shared.setObject(image, forKey: url as NSString)
                    self?.imageView.image = image
                }
            }
        }.resume()
    }

    private func showPlaceholderImage() {
        DispatchQueue.main.async {
            self.imageView.image = UIImage(named: "placeholder")  // Placeholder image
        }
    }

}
