//
//  MoviesListTableViewController.swift
//  NextMovies
//
//  Created by Tiago Chaves on 09/11/18.
//  Copyright © 2018 Next. All rights reserved.
//

import UIKit

class MoviesListTableViewController: UITableViewController {

    let movieCellIdentifier = "movieCell"
    let highlightMovieCellIdentifier = "highlightMovieCell"
    
    var movies:[Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.loadMovies()
    }
    
    private func loadMovies() {
        
        let worker = MockMoviesWorker()
        MoviesWorker(worker: worker).getMovies(ofPage: 0) { (movies, error) in
            
            if error == nil, let movies = movies {
                
                self.movies = movies
                self.tableView.reloadData()
            }else{
                print("Erro ao tentar recuperar a lista de filmes: \(error?.localizedDescription ?? "-")")
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let movie = movies[indexPath.row]
        
        switch movie.itemType! {
        case .movie:
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: movieCellIdentifier, for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }
            
            cell.configCell(withMovie: movie)
            return cell
        case .list:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: highlightMovieCellIdentifier, for: indexPath) as? HighlightMoviesTableViewCell else { return UITableViewCell() }
            
            cell.configCell(withMovies: movie.items ?? [])
            return cell
        }
    }

}
