//
//  Bundle-Decodable.swift
//  Moonshot
//
//  Created by Pooja Agrawal on 21/06/23.
//

import Foundation


extension Bundle {
    func decode<T: Codable>( _ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate file \(file) in bundle")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load file \(file) from bundle")
        }
        
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode file \(file) from bundle")
        }
        
        return loaded
    }
}
