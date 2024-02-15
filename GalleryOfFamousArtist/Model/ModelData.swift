//
//  ModelData.swift
//  GalleryOfFamousArtist
//
//  Created by Иван Захаров on 13.02.2024.
//

import Foundation

final class ModelData {
    
    lazy var artists: [Artist] = load("artists.json")
    
    
    func load(_ filename: String) -> [Artist] {
        let data: Data
        let decoder = JSONDecoder()
        
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
            fatalError("Couldn't find \(filename) in main bundle")
        }
        
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle: \n\(error)")
        }
        
        do {
            let decodedData = try decoder.decode(Artists.self, from: data)
            return decodedData.artists
        } catch {
            fatalError("Couldn't parse \(filename) as \(Artists.self):\n\(error)")
        }
    }
}
