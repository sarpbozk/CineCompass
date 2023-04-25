//
//  MovieManager.swift
//  CineCompass
//
//  Created by Muhammet BOZKURT on 20.04.2023.
//

import Foundation

final class MovieManager {
    let searchURL = "https://api.themoviedb.org/3/search/movie"
    let detailsURL = "https://api.themoviedb.org/3/movie"
    let apiKey = "87027965472f4df58ab7f4cfb6212185"
    
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
            if let movies = self?.parseMovieData(data) {
                for movie in movies {
                    print("Title: \(movie.title)")
                    print("id: \(movie.id)")
                }
            }
        }
        // start the task
        task.resume()
    }
    
    func getMovieDetails(using movieID: Int) {
        let urlString = "\(detailsURL)/\(movieID)?api_key=\(apiKey)"
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
                print("no data received")
                return
            }
            if let movieDetails = self?.parseMovieDetailsData(data) {
                print("Title: \(movieDetails.title) ")
                print("Relased in: \(movieDetails.releaseDate)")
                for genre in movieDetails.genres {
                    print(genre.name)
                }
                print("Average Score: \(movieDetails.voteAverage) ")
                print("Lenght: \(movieDetails.runtime) minutes")
                print("Overview: \(movieDetails.overview)")
            }
        }
        task.resume()
    }
    
    
    func parseMovieData(_ data: Data) -> [Movie]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(MovieData.self, from: data)
            return decodedData.results
        } catch {
            print("error decoding JSON")
            return nil
        }
    }
    
    func parseMovieDetailsData(_ data: Data) -> MovieDetailsDataResponse? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(MovieDetailsDataResponse.self, from: data)
            return decodedData
        } catch {
            print("error decoding JSON")
            return nil
        }
    }
}
