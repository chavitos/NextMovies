//
//  CoreDataMoviesWorker.swift
//  NextMovies
//
//  Created by Tiago Chaves on 16/11/18.
//  Copyright © 2018 Next. All rights reserved.
//

import Foundation
import CoreData

class CoreDataMoviesWorker:MoviesWorkerProtocol {
    
    func getMovies(ofPage page: Int, completionHandler: @escaping (() throws -> [MovieModel]) -> Void) {
        
        let fetch:NSFetchRequest<Movie> = Movie.fetchRequest()
        do{
            
            let movies = try CoreDataManager.sharedInstance.persistentContainer.viewContext.fetch(fetch)
            var moviesModel:[MovieModel] = []
            for movie in movies{
                let model = movie.getModel()
                moviesModel.append(model)
            }
            
            completionHandler{ return moviesModel }
        }catch{
            completionHandler{ throw error }
        }
    }
}
