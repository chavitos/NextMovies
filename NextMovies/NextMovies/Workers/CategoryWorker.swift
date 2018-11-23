//
//  CategoryWorker.swift
//  NextMovies
//
//  Created by Tiago Chaves on 16/11/18.
//  Copyright © 2018 Next. All rights reserved.
//

import Foundation

class CotegoryWorker{
    
    var worker:CategoriesWorkerProtocol
    
    init(worker:CategoriesWorkerProtocol) {
        self.worker = worker
    }
    
    func getCategories(completionHandler:@escaping (([CategoryModel]?,Error?) -> Void)){
        
        worker.getCategories { (categories:() throws -> [CategoryModel]) in
            
            do {
                let category = try categories()
                completionHandler(category,nil)
            }catch let error{
                completionHandler(nil,error)
            }
        }
    }
}


protocol CategoriesWorkerProtocol{
    
    func getCategories(completionHandler:@escaping (() throws -> [CategoryModel]) -> Void)
}
