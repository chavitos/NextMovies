//
//  MockCategoryWorker.swift
//  NextMovies
//
//  Created by Tiago Chaves on 16/11/18.
//  Copyright © 2018 Next. All rights reserved.
//

import UIKit

class MockCategoryWorker:CategoriesWorkerProtocol {
    
    func getCategories(completionHandler: @escaping (() throws -> [CategoryModel]) -> Void) {
        
        guard let data = NSDataAsset(name: "categories")?.data else { return }
        
        do{
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase //já 'elimina' os _
            let categories = try decoder.decode([CategoryModel].self, from: data)
            
            for category in categories {
                category.saveInCoreData()
            }
            
            completionHandler{ return categories }
        }catch{
            completionHandler{ throw error }
        }
    }
}
