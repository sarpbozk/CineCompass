//
//  MovieCell.swift
//  CineCompass
//
//  Created by Muhammet BOZKURT on 25.04.2023.
//

import UIKit

class MovieCell: UITableViewCell {
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
