//
//  MovieDetailViewController.swift
//  NextMovies
//
//  Created by Tiago Chaves on 09/11/18.
//  Copyright © 2018 Next. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var movieImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var summaryTextView: UITextView!
    
    var movie:Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadMovieInfo()
    }
    
    private func loadMovieInfo() {
        
        if let movie = self.movie {
            
            print(movie)
        }
    }

    @IBAction func playTrailer(_ sender: Any) {
        
        print("Playing trailer!")
    }
    
    @IBAction func back(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
}
