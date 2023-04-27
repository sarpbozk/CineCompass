//
//  MovieDetailsViewController.swift
//  CineCompass
//
//  Created by Muhammet BOZKURT on 25.04.2023.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    var movieDetails: MovieDetailsDataResponse?
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieReleaseDate: UILabel!
    @IBOutlet weak var movieVoteAvg: UILabel!
    @IBOutlet weak var movieGenres: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        movieTitle.text = movieDetails?.title
        movieReleaseDate.text = movieDetails?.releaseDate
        movieVoteAvg.text = String(format: "%.1f", movieDetails?.voteAverage ?? -9999.9999)
        movieGenres.text = (movieDetails?.genres[0].name ?? " ") + "   " + (movieDetails?.genres[1].name ?? " ") + "   " + (movieDetails?.genres[2].name ?? " ")
        movieOverview.text = movieDetails?.overview
        
        let baseURL = "https://image.tmdb.org/t/p/w500/"
        if let posterPath = movieDetails?.posterPath {
            let posterURL = URL(string: baseURL + posterPath)
            moviePoster.kf.setImage(with: posterURL)
        }
    }
}
