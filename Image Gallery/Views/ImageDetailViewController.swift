//
//  ImageDetailViewController.swift
//  Image Gallery
//
//  Created by Balkrishna Choudhary on 30/09/24.
//

import UIKit

class ImageDetailViewController: UIViewController {
    
    // Add this property to hold the selected photo
    var photo: Photo?

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    //@IBOutlet weak var imageView: UIImageView?
   // @IBOutlet weak var titleLabel: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    private func updateUI() {
        guard let photo = photo else { return }
        self.titleLabel.text = photo.title
        loadImage(from: photo.url)
    }
    
    private func loadImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: imageURL) { [weak self] data, _, _ in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.imageView.image = image
                }
            }
        }.resume()
    }
}

