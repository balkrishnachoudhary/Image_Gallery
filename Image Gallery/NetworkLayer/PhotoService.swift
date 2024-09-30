//
//  PhotoService.swift
//  Image Gallery
//
//  Created by Balkrishna Choudhary on 30/09/24.
//

import Foundation

class PhotoService {
    func fetchPhotos(completion: @escaping ([Photo]?, Error?) -> Void) {
        let url = URL(string: "https://jsonplaceholder.typicode.com/photos")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"]))
                return
            }
            
            let photos = try? JSONDecoder().decode([Photo].self, from: data)
            completion(photos, nil)
        }.resume()
    }
}

