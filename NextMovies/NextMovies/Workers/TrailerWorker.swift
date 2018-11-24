//
//  TrailerWorker.swift
//  NextMovies
//
//  Created by Tiago Chaves on 24/11/18.
//  Copyright © 2018 Next. All rights reserved.
//

import Foundation

class TrailerWorker{
    
    var worker:TrailerWorkerProtocol
    
    init(worker:TrailerWorkerProtocol) {
        self.worker = worker
    }
    
    func getMovies(ofMovie movie:String, completionHandler:@escaping ((TrailerResult?,Error?) -> Void)){
        
        worker.getMovieInfo(ofMovie:movie) { (trailers:() throws -> TrailerResult) in
            
            do {
                let movieInfo = try trailers()
                completionHandler(movieInfo,nil)
            }catch let error{
                completionHandler(nil,error)
            }
        }
    }
}

protocol TrailerWorkerProtocol{
    
    func getMovieInfo(ofMovie movie:String,completionHandler:@escaping (() throws -> TrailerResult) -> Void)
}
