//
//  ViewController.swift
//  CineCompass
//
//  Created by Muhammet BOZKURT on 19.04.2023.
//

import UIKit

class ViewController: UIViewController {
    let movieManager = MovieManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        movieManager.searchMovies(movieName: "Interstellar")
    }
        
    @IBAction func detailsButtonPressed(_ sender: UIButton) {
        movieManager.getMovieDetails(using: 157336)
    }
}

