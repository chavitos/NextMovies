//
//  MovieTableViewCell.swift
//  NextMovies
//
//  Created by Tiago Chaves on 09/11/18.
//  Copyright © 2018 Next. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet private weak var movieImagieView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        
        movieImagieView.image = nil
        
        titleLabel.text         = ""
        descriptionLabel.text   = ""
        ratingLabel.text        = ""
    }

    func configCell(withMovie movie:MovieModel) {
        
        if let imageData = movie.poster, let image = UIImage(data: imageData) {
            movieImagieView.image = image
        }
        
        titleLabel.text         = movie.title
        descriptionLabel.text   = movie.summary ?? ""
        ratingLabel.text        = "⭐️ \(movie.rating?.rounded() ?? 0)/5 "
    }

}
