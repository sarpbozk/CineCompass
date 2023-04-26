//
//  ViewController.swift
//  CineCompass
//
//  Created by Muhammet BOZKURT on 19.04.2023.
//

import UIKit

class SearchViewController: UIViewController {
    let movieManager = MovieManager()
    @IBOutlet weak var movieSearchTextField: UISearchBar!
    override func viewDidLoad() {
        movieManager.delegate = self
        movieSearchTextField.delegate = self
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.searchSegue {
            if let navigationController = segue.destination as? UINavigationController,
               let searchResultsVC = navigationController.viewControllers.first as? SearchResultsViewController,
                let movies = sender as? [Movie] {
                print("Passing movies to SearchResultsViewController: \(movies)")
                searchResultsVC.movies = movies
            }
        }
    }
}
extension SearchViewController: MovieManagerDelegate {
    func didReceiveMovies(_ movies: [Movie]) {
//        print("Received movies: \(movies)")
        DispatchQueue.main.async {
//            print("Performing segue with movies: \(movies)")
            self.performSegue(withIdentifier: K.searchSegue, sender: movies)
        }
    }
}
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let movieName = searchBar.text {
//            print("Searching for movie: \(movieName)")
            
            movieManager.searchMovies(movieName: movieName)

        }
    }
}
