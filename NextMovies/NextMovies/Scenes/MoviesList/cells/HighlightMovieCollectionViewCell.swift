//
//  HighlightMovieCollectionViewCell.swift
//  NextMovies
//
//  Created by Tiago Chaves on 09/11/18.
//  Copyright © 2018 Next. All rights reserved.
//

import UIKit

class HighlightMovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    func configCell(withMovie movie:MovieModel) {
        
        self.titleLabel.text = movie.title
        self.posterImageView.image = UIImage(named: movie.image ?? "")
    }
}

