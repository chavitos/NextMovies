//
//  CategoryModel.swift
//  NextMovies
//
//  Created by Tiago Chaves on 16/11/18.
//  Copyright © 2018 Next. All rights reserved.
//

import Foundation
import CoreData

struct CategoryModel:Codable {
    let name:String
    
    func saveInCoreData(){
        
        let category = Category(context: CoreDataManager.sharedInstance.persistentContainer.viewContext)
        
        category.name = self.name
        
        CoreDataManager.sharedInstance.saveContext()
        print("Categoria salva.")
    }
}
