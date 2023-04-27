//
//  SearchResultsViewController.swift
//  CineCompass
//
//  Created by Muhammet BOZKURT on 25.04.2023.
//

import UIKit
import Kingfisher

class SearchResultsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var movies: [Movie] = []
    let movieManager = MovieManager()
    
    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.delegate = self
        movieManager.detailsDelegate = self
        super.viewDidLoad()
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.detailSegue {
            if let movieDetailsVC = segue.destination as? MovieDetailsViewController, let movieDetails = sender as? MovieDetailsDataResponse {
                movieDetailsVC.movieDetails = movieDetails
            }
        }
    }

}
extension SearchResultsViewController: MovieManagerDetailsDelegate {
    func didReceiveMovieDetails(_ movieDetails: MovieDetailsDataResponse) {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: K.detailSegue, sender: movieDetails)
        }
    }
}
extension SearchResultsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MovieCell
        cell.movieName.text = movies[indexPath.row].title
        let baseURL = "https://image.tmdb.org/t/p/w500/"
        if let posterPath = movies[indexPath.row].posterPath {
            let posterURL = URL(string: baseURL + posterPath)
            cell.moviePoster.kf.setImage(with: posterURL)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMovie = movies[indexPath.row]
        movieManager.getMovieDetails(using: selectedMovie.id)
    }
}
