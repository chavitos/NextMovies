//
//  Movie.swift
//  NextMovies
//
//  Created by Tiago Chaves on 09/11/18.
//  Copyright © 2018 Next. All rights reserved.
//

import Foundation
import CoreData

enum ItemType:String,Codable {
    
    case movie  = "movie"
    case list   = "list"
}

struct MovieModel:Codable{
    
    let title       :String
    let categories  :[String]?
    let duration    :String?
    let rating      :Double?
    let summary     :String?
    let image       :String?
    let itemType    :ItemType?
    let items       :[MovieModel]?
    var poster      :Data?
    
    enum CodingKeys:String,CodingKey {
        
        case title
        case categories
        case duration
        case rating
        case summary        = "description"
        case image
        case itemType
        case items
    }
    
    init(title:String, categories:[String]?,duration:String?,rating:Double?,summary:String?,poster:Data?){
        
        self.title = title
        self.categories = categories
        self.duration = duration
        self.rating = rating
        self.summary = summary
        self.poster = poster
        self.image = nil
        self.itemType = .movie
        self.items = nil
    }
    
    init() {
        self.init(title: "", categories: nil, duration: nil, rating: nil, summary: nil, poster: nil)
    }
    
    func getCoreDataObj() -> Movie? {
        
        if let coredataObj:Movie = CoreDataManager.sharedInstance.getData(ofEntity: Movie.fetchRequest(), withPredicate: NSPredicate(format: "title == %@", self.title)).first{
            
            return coredataObj
        }
        
        return nil
    }
}
