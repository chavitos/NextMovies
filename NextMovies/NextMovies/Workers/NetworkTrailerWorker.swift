//
//  NetworkTrailerWorker.swift
//  NextMovies
//
//  Created by Tiago Chaves on 24/11/18.
//  Copyright © 2018 Next. All rights reserved.
//

import Foundation

class NetworkTrailerWorker:TrailerWorkerProtocol {
    
    func getMovieInfo(ofMovie movie: String, completionHandler: @escaping (() throws -> TrailerResult) -> Void) {
        
        let request = MovieNextRequests.getMovieInfo(movie)
        NetworkManager.getData(ofURL: request) { (data, error) in
            
            if error == nil, let data = data {
                
                do{
                    let movieInfo = try JSONDecoder().decode(TrailerResult.self, from: data)
                    completionHandler { return movieInfo }
                }catch{
                    completionHandler { throw error }
                }
            }
        }
    }
}
