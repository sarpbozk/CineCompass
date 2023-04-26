//
//  MovieManager.swift
//  CineCompass
//
//  Created by Muhammet BOZKURT on 20.04.2023.
//

import Foundation

protocol MovieManagerDelegate: AnyObject {
    func didReceiveMovies(_ movies: [Movie])
}

final class MovieManager {
    let searchURL = "https://api.themoviedb.org/3/search/movie"
    let detailsURL = "https://api.themoviedb.org/3/movie"
    let apiKey = "87027965472f4df58ab7f4cfb6212185"
    weak var delegate: MovieManagerDelegate?
    func searchMovies(movieName: String) {
        let encodedMovieName = movieName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "\(searchURL)?api_key=\(apiKey)&query=\(encodedMovieName)"
        // create url
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
//        print("URL: \(url)")
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
//            print("ReceivedData: \(String(data: data, encoding: .utf8) ?? "No Data")")
            if let movies = self?.parseMovieData(data) {
                self?.delegate?.didReceiveMovies(movies)
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
//            print("Parsed movies: \(decodedData.results)")
            return decodedData
        } catch {
            print("error decoding JSON")
            return nil
        }
    }
}
