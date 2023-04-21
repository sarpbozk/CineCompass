//
//  MovieManager.swift
//  CineCompass
//
//  Created by Muhammet BOZKURT on 20.04.2023.
//

import Foundation

final class MovieManager {
    let searchURL = "https://api.themoviedb.org/3/search/movie"
    let apiKey = "replace this text with your api key"
    
    func searchMovies(movieName: String) {
        let urlString = "\(searchURL)?api_key=\(apiKey)&query=\(movieName)"
        // create url
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        // create urlsession
        let session = URLSession(configuration: .default)
        // create url session a task
        let task = session.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                print(error)
            }
            guard let data = data else {
                print("No data received")
                return
            }
//            print(String(data: data, encoding: .utf8)!)
            if let movies = self?.parseJSON(data) {
                for movie in movies {
                    print("Title: \(movie.title)")
                }
            }
        }
        // start the task
        task.resume()
    }
    
    func parseJSON(_ data: Data) -> [Movie]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(MovieData.self, from: data)
            return decodedData.results
        } catch {
            print("error decoding JSON")
            return nil
        }
        
    }
}
