//
//  Movie+CoreDataClass.swift
//  NextMovies
//
//  Created by Tiago Chaves on 16/11/18.
//  Copyright © 2018 Next. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Movie)
public class Movie: NSManagedObject {

    func getModel() -> MovieModel {
        
        guard let title = self.title, let duration = self.duration, let summary = self.summary else { return MovieModel() }
        
        var categories:[String] = []
        for category in self.categories ?? [] {
            
            categories.append(category.name ?? "")
        }
        
        return MovieModel(title: title, categories: categories, duration: duration, rating: self.rating, summary: summary, poster: self.image)
    }
}
