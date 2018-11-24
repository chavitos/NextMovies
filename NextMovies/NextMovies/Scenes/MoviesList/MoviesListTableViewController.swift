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
    
    var movies:[MovieModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        self.view.tintColor = UIColor.white
        self.navigationController?.view.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        tableView.allowsSelectionDuringEditing = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadMovies()
    }
    
    private func loadMovies() {
        
        let worker = CoreDataMoviesWorker()
        MoviesWorker(worker: worker).getMovies(ofPage: 0) { [weak self] (movies, error) in
            
            guard let self = self else { return }
            
            if error == nil, let movies = movies {
                
                if movies.count > 0{
                    self.movies = movies
                    self.tableView.backgroundView = nil
                    self.tableView.reloadData()
                }else{
                    
                    let emptyLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0,
                                                                    width: self.tableView.bounds.size.width,
                                                                    height: self.tableView.bounds.size.height))
                    emptyLabel.text          = "Não há filmes!"
                    emptyLabel.textColor     = UIColor.white
                    emptyLabel.backgroundColor = UIColor.black
                    emptyLabel.textAlignment = .center
                    self.tableView.backgroundView  = emptyLabel
                    self.tableView.separatorStyle  = .none
                }
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.isEditing {
            performSegue(withIdentifier: "segueMoviesListToAdd", sender: self)
        }else{
            performSegue(withIdentifier: "segueMoviesListToDetail", sender: self)
        }
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
            
            let movie = movies[indexPath.row]
            if let coredataObj = movie.getCoreDataObj() {
             
                if CoreDataManager.sharedInstance.deleteInCoreData(object: coredataObj) {
                    
                    movies = movies.filter { $0.title != movie.title }
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }
            }
            
            loadMovies()
        }
    }
    
    @IBAction func addMovie(_ sender: Any) {
        
        performSegue(withIdentifier: "segueMoviesListToAdd", sender: self)
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segueMoviesListToDetail" {
            
            let detail = segue.destination as? MovieDetailViewController
            if let indexPath = tableView.indexPathForSelectedRow {
                
                let movie = movies[indexPath.row]
                detail?.movie = movie
            }
        }else if segue.identifier == "segueMoviesListToAdd" {
            
            let edit = segue.destination as? AddMovieViewController
            if let indexPath = tableView.indexPathForSelectedRow {
                
                let movie = movies[indexPath.row]
                edit?.movie = movie.getCoreDataObj()
            }
        }
    }
}
