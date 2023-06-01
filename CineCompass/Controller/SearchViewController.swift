//
//  ViewController.swift
//  CineCompass
//
//  Created by Muhammet BOZKURT on 19.04.2023.
//

import UIKit

class SearchViewController: UIViewController, UICollectionViewDataSource, MovieManagerDetailsDelegate {
    func didReceiveMovieDetails(_ movieDetails: MovieDetailsDataResponse) {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: K.detailSegue, sender: movieDetails)
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == popularMoviesCollectionView {
            return popularMovies.count
        } else if collectionView == upcomingMoviesCollectionView {
            return upcomingMovies.count
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // First, identify the array to use based on the collectionView.
        let moviesArray: [Movie]
        if collectionView == popularMoviesCollectionView {
            moviesArray = popularMovies
        } else if collectionView == upcomingMoviesCollectionView {
            moviesArray = upcomingMovies
        } else {
            // It's not one of the expected collection views.
            // Return a blank cell to prevent crash, but you should never reach this point.
            return UICollectionViewCell()
        }

        // Dequeue a cell from the correct collectionView and configure it.
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCellIdentifier", for: indexPath) as? MovieCollectionViewCell {
            let movie = moviesArray[indexPath.item]
            cell.configureWithMovie(movie)
            return cell
        } else {
            // If unable to dequeue a MovieCollectionViewCell, return a blank cell to prevent crash.
            return UICollectionViewCell()
        }
    }

    var popularMovies: [Movie] = []
    var upcomingMovies: [Movie] = []
    let movieManager = MovieManager()
    @IBOutlet weak var movieSearchTextField: UISearchBar!
    
    override func viewDidLoad() {
        movieManager.delegate = self
        movieSearchTextField.delegate = self
        movieManager.detailsDelegate = self
        super.viewDidLoad()
        popularMoviesCollectionView.delegate = self
        popularMoviesCollectionView.dataSource = self

        upcomingMoviesCollectionView.delegate = self
        upcomingMoviesCollectionView.dataSource = self
        
        movieManager.getPopularMovies()
        movieManager.getUpcomingMovies()
        let nib = UINib(nibName: "MovieCollectionViewCell", bundle: nil)
            self.popularMoviesCollectionView.register(nib, forCellWithReuseIdentifier: "movieCellIdentifier")
            self.upcomingMoviesCollectionView.register(nib, forCellWithReuseIdentifier: "movieCellIdentifier")

        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.searchSegue {
            if let navigationController = segue.destination as? UINavigationController,
               let searchResultsVC = navigationController.viewControllers.first as? SearchResultsViewController {
                if let movies = sender as? [Movie] {
                    print("Passing movies to SearchResultsViewController: \(movies)")
                    searchResultsVC.movies = movies
                }
            }
        } else if segue.identifier == K.detailSegue {
            if let movieDetailsVC = segue.destination as? MovieDetailsViewController,
               let movieDetails = sender as? MovieDetailsDataResponse {
                movieDetailsVC.movieDetails = movieDetails
            }
        }
    }
    
    @IBOutlet weak var popularMoviesCollectionView: UICollectionView!
    
    @IBOutlet weak var upcomingMoviesCollectionView: UICollectionView!
    
}
extension SearchViewController: MovieManagerDelegate {
    func didReceiveMovies(_ movies: [Movie]) {
//        print("Received movies: \(movies)")
        DispatchQueue.main.async {
//            print("Performing segue with movies: \(movies)")
            self.performSegue(withIdentifier: K.searchSegue, sender: movies)
        }
    }
    func didReceivePopularMovies(_ movies: [Movie]) {
        DispatchQueue.main.async {
            self.popularMovies = movies
            self.popularMoviesCollectionView.reloadData()
        }
    }

    func didReceiveUpcomingMovies(_ movies: [Movie]) {
        DispatchQueue.main.async {
            self.upcomingMovies = movies
            self.upcomingMoviesCollectionView.reloadData()
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
extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Here you specify the size you want for your cells.
        // This is just an example, adjust the width and height to fit your needs.
        if let layout = popularMoviesCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        if let layout = upcomingMoviesCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        let cellWidth = collectionView.bounds.width / 3
        let cellHeight = collectionView.bounds.height / 2
        return CGSize(width: cellWidth, height: cellHeight)
    }
}

extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // First, identify the array to use based on the collectionView.
        let moviesArray: [Movie]
        if collectionView == popularMoviesCollectionView {
            moviesArray = popularMovies
        } else if collectionView == upcomingMoviesCollectionView {
            moviesArray = upcomingMovies
        } else {
            return // It's not one of the expected collection views, so we return early.
        }

        let selectedMovie = moviesArray[indexPath.item]
        movieManager.getMovieDetails(using: selectedMovie.id)
    }
}
