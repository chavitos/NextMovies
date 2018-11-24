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
    
    var movie:MovieModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadMovieInfo()
    }
    
    private func loadMovieInfo() {
        
        if let movie = self.movie {
            
            titleLabel.text = movie.title
            durationLabel.text = movie.duration
            ratingLabel.text = "⭐️ \(movie.rating?.rounded() ?? 0)/5"
            summaryTextView.text = movie.summary
            
            if let imageData = movie.poster, let image = UIImage(data: imageData) {
                movieImageView.image = image
            }else{
                movieImageView.image = UIImage(named: "placeholder")
            }
            
            if let categories = movie.categories, categories.count > 0 {
                
                var categoriesString = ""
                
                for (index,category) in categories.enumerated() {
                    
                    if index == 0{
                        categoriesString = category
                    }else{
                        categoriesString = categoriesString + "|" + category
                    }
                }
                
                categoriesLabel.text = categoriesString
            }else{
                categoriesLabel.text = "-"
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segueDetailToEdit", let editVC = segue.destination as? AddMovieViewController {
            
            editVC.movie = self.movie?.getCoreDataObj()
        }
    }

    @IBAction func playTrailer(_ sender: Any) {
        
        print("Playing trailer!")
    }
    
    @IBAction func editMovie(_ sender: Any) {
        performSegue(withIdentifier: "segueDetailToEdit", sender: self)
    }
    
    @IBAction func back(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
}
