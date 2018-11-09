//
//  MockMoviesWorker.swift
//  NextMovies
//
//  Created by Tiago Chaves on 09/11/18.
//  Copyright © 2018 Next. All rights reserved.
//

import UIKit

class MockMoviesWorker:MoviesWorkerProtocol {
    
    func getMovies(ofPage page: Int, completionHandler: @escaping (() throws -> [Movie]) -> Void) {
        
        guard let data = NSDataAsset(name: "movies")?.data else { return }
        
        do{
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase //já 'elimina' os _
            let movies = try decoder.decode([Movie].self, from: data)
            
            completionHandler{ return movies }
        }catch{
            completionHandler{ throw error }
        }
    }
}
