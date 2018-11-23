//
//  MoviesWorker.swift
//  NextMovies
//
//  Created by Tiago Chaves on 09/11/18.
//  Copyright © 2018 Next. All rights reserved.
//

import Foundation

class MoviesWorker{
    
    var worker:MoviesWorkerProtocol
    
    init(worker:MoviesWorkerProtocol) {
        self.worker = worker
    }
    
    func getMovies(ofPage page:Int, completionHandler:@escaping (([MovieModel]?,Error?) -> Void)){
        
        worker.getMovies(ofPage: page) { (movies:() throws -> [MovieModel]) in
            
            do {
                let movies = try movies()
                completionHandler(movies,nil)
            }catch let error{
                completionHandler(nil,error)
            }
        }
    }
}


protocol MoviesWorkerProtocol{
    
    func getMovies(ofPage page:Int, completionHandler:@escaping (() throws -> [MovieModel]) -> Void)
}
