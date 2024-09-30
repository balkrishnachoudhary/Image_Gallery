//
//  ImageDetailViewModel.swift
//  Image Gallery
//
//  Created by Balkrishna Choudhary on 30/09/24.
//

import Foundation

class ImageDetailViewModel {
    private let photos: [Photo]
    private var currentIndex: Int
    
    var currentPhoto: Photo {
        return photos[currentIndex]
    }
    
    init(photos: [Photo], currentIndex: Int) {
        self.photos = photos
        self.currentIndex = currentIndex
    }
    
    func nextPhoto() {
        if currentIndex < photos.count - 1 {
            currentIndex += 1
        }
    }
    
    func previousPhoto() {
        if currentIndex > 0 {
            currentIndex -= 1
        }
    }
}
