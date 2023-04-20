//
//  ViewController.swift
//  CineCompass
//
//  Created by Muhammet BOZKURT on 19.04.2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        let movieManager = MovieManager()
        movieManager.searchMovies(movieName: "Interstellar")
    }
    
}

