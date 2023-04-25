//
//  ViewController.swift
//  CineCompass
//
//  Created by Muhammet BOZKURT on 19.04.2023.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {
    let movieManager = MovieManager()
    @IBOutlet weak var movieSearchTextField: UISearchBar!
    override func viewDidLoad() {
        movieSearchTextField.delegate = self
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

