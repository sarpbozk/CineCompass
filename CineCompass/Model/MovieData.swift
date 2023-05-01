//
//  MovieData.swift
//  CineCompass
//
//  Created by Muhammet BOZKURT on 20.04.2023.
//

import Foundation

struct MovieData: Codable {
    let results: [Movie]
}
struct Movie: Codable {
    let id: Int
    let title: String
    let posterPath: String?
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
    }
}
