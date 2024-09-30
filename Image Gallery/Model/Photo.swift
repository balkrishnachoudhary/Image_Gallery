//
//  Photo.swift
//  Image Gallery
//
//  Created by Balkrishna Choudhary on 30/09/24.
//

import Foundation

struct Photo: Codable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}
