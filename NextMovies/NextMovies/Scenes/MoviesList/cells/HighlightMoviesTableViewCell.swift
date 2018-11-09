//
//  HighlightMoviesTableViewCell.swift
//  NextMovies
//
//  Created by Tiago Chaves on 09/11/18.
//  Copyright © 2018 Next. All rights reserved.
//

import UIKit

class HighlightMoviesTableViewCell: UITableViewCell {

    let movieCollectionCellIdentifier = "movieCollectionCell"
    
    @IBOutlet weak var collection: UICollectionView!
    var movies:[Movie] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.collection.dataSource = self
    }

    func configCell(withMovies movies:[Movie]) {
        
        self.movies = movies
        collection.reloadData()
    }
}

extension HighlightMoviesTableViewCell:UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collection.dequeueReusableCell(withReuseIdentifier: movieCollectionCellIdentifier, for: indexPath) as? HighlightMovieCollectionViewCell else { return UICollectionViewCell() }
        
        let movie = movies[indexPath.row]
        cell.configCell(withMovie: movie)
        
        return cell
    }
}
