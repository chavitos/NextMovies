//
//  Category+CoreDataProperties.swift
//  NextMovies
//
//  Created by Tiago Chaves on 16/11/18.
//  Copyright © 2018 Next. All rights reserved.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var name: String?
    @NSManaged public var movies: Set<Movie>?
}

// MARK: Generated accessors for movies
extension Category {

    @objc(addMoviesObject:)
    @NSManaged public func addToMovies(_ value: Movie)

    @objc(removeMoviesObject:)
    @NSManaged public func removeFromMovies(_ value: Movie)

    @objc(addMovies:)
    @NSManaged public func addToMovies(_ values: Set<Movie>?)

    @objc(removeMovies:)
    @NSManaged public func removeFromMovies(_ values: Set<Movie>?)

}
