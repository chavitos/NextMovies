//
//  Movie+CoreDataProperties.swift
//  NextMovies
//
//  Created by Tiago Chaves on 16/11/18.
//  Copyright © 2018 Next. All rights reserved.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var title: String?
    @NSManaged public var trailerUrl: String?
    @NSManaged public var duration: String?
    @NSManaged public var rating: Double
    @NSManaged public var summary: String?
    @NSManaged public var image: Data?
    @NSManaged public var categories: Set<Category>?
}

// MARK: Generated accessors for categories
extension Movie {

    @objc(addCategoriesObject:)
    @NSManaged public func addToCategories(_ value: Category)

    @objc(removeCategoriesObject:)
    @NSManaged public func removeFromCategories(_ value: Category)

    @objc(addCategories:)
    @NSManaged public func addToCategories(_ values: Set<Category>)

    @objc(removeCategories:)
    @NSManaged public func removeFromCategories(_ values: Set<Category>)

}
