//
//  Model.swift
//  GalleryOfFamousArtist
//
//  Created by Иван Захаров on 13.02.2024.
//

import Foundation

struct Artists: Decodable {
    let artists: [Artist]
}

struct Artist: Decodable {
    let name: String
    let bio: String
    let image: String
    let works: [Work]
    
}

struct Work: Decodable {
    let title: String
    let image: String
    let info: String
}
