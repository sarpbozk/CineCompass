//
//  MovieManager.swift
//  CineCompass
//
//  Created by Muhammet BOZKURT on 20.04.2023.
//

import Foundation

protocol MovieManagerDelegate: AnyObject {
    func didReceiveMovies(_ movies: [Movie])
    func didReceivePopularMovies(_ movies: [Movie])
    func didReceiveUpcomingMovies(_ movies: [Movie])
}
protocol MovieManagerDetailsDelegate: AnyObject {
    func didReceiveMovieDetails(_ movieDetails: MovieDetailsDataResponse)
}

final class MovieManager {
    
    weak var delegate: MovieManagerDelegate?
    weak var detailsDelegate: MovieManagerDetailsDelegate?
    
    private let session = URLSession(configuration: .default)
    
    func searchMovies(movieName: String) {
        let encodedMovieName = movieName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "\(K.searchURL)?api_key=\(K.apiKey)&query=\(encodedMovieName)"
        fetchData(urlString: urlString) { data in
            if let movies = self.parseMovieData(data) {
                self.delegate?.didReceiveMovies(movies)
            }
        }
    }
    
    func getMovieDetails(using movieID: Int) {
        let urlString = "\(K.detailsURL)/\(movieID)?api_key=\(K.apiKey)"
        fetchData(urlString: urlString) { data in
            if let movieDetails = self.parseMovieDetailsData(data) {
                self.detailsDelegate?.didReceiveMovieDetails(movieDetails)
            }
        }
    }
    
    func getPopularMovies() {
        let urlString = "\(K.popularMoviesURL)?api_key=\(K.apiKey)&language=en-US&page=1"
        fetchData(urlString: urlString) { data in
            if let movies = self.parseMovieData(data) {
                self.delegate?.didReceivePopularMovies(movies)
                print(movies)
            }
        }
    }
    
    func getUpcomingMovies() {
        let urlString = "\(K.upcomingMoviesURL)?api_key=\(K.apiKey)&language=en-US&page=1"
        fetchData(urlString: urlString) { data in
            if let movies = self.parseMovieData(data) {
                self.delegate?.didReceiveUpcomingMovies(movies)
                print(movies)

            }
        }
    }
    
    
    private func parseMovieData(_ data: Data) -> [Movie]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(MovieData.self, from: data)
            return decodedData.results
        } catch {
            print("error decoding JSON")
            return nil
        }
    }
    
    private func parseMovieDetailsData(_ data: Data) -> MovieDetailsDataResponse? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(MovieDetailsDataResponse.self, from: data)
            return decodedData
        } catch {
            print("error decoding JSON")
            return nil
        }
    }
    
    private func fetchData(urlString: String, completion: @escaping (Data) -> Void) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        let task = session.dataTask(with: url) { [weak self] data, response, error in
            guard self != nil else {return}
            if let error = error {
                print(error)
            }
            guard let data = data else {
                print("no data received")
                return
            }
            completion(data)
        }
        task.resume()
    }
}
