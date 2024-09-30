//
//  ImageGridViewModel.swift
//  Image Gallery
//
//  Created by Balkrishna Choudhary on 30/09/24.
//

import Foundation

class ImageGridViewModel {
    private let photoService = PhotoService()
    private(set) var photos: [Photo] = []
    
    var isLoading: ((Bool) -> Void)?   // Closure to update loading state
    var didUpdatePhotos: (() -> Void)?
    var didFailWithError: ((String) -> Void)?  // Closure to handle errors
    
    func fetchPhotos() {
        isLoading?(true)
        photoService.fetchPhotos { [weak self] photos, error in
            self?.isLoading?(false)
            
            if let error = error {
                self?.didFailWithError?(error.localizedDescription)
                return
            }
            
            guard let photos = photos else { return }
            self?.photos = photos
            DispatchQueue.main.async {
                self?.didUpdatePhotos?()
            }
        }
    }
    
    func numberOfItems() -> Int {
        return photos.count
    }
    
    func photo(at indexPath: IndexPath) -> Photo {
        return photos[indexPath.item]
    }
}

