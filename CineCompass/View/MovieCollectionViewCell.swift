//
//  MovieCollectionViewCell.swift
//  CineCompass
//
//  Created by Muhammet BOZKURT on 1.06.2023.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    // Assuming you have an UIImageView and UILabel in your cell to display poster and title
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    func configureWithMovie(_ movie: Movie) {
        titleLabel.text = movie.title
        if let posterPath = movie.posterPath {
            let posterURL = URL(string: K.posterImageBaseUrl + posterPath)
            posterImageView.kf.setImage(with: posterURL)
        }
    }
}

