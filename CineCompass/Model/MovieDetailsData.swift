//
//  MovieDetailsData.swift
//  CineCompass
//
//  Created by Muhammet BOZKURT on 22.04.2023.
//

import Foundation

struct MovieDetailsData: Codable {
    let title: String
    let genres: [Genre]
    let overview: String
    let releaseDate: String
    let voteAverage: Double
    let posterPath: String
    let runtime: Int
    
    enum CodingKeys: String, CodingKey {
        case title
        case genres
        case overview
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case posterPath = "poster_path"
        case runtime
    }
}

struct Genre: Codable {
    let name: String
}
