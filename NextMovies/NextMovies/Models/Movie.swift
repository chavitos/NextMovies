//
//  Movie.swift
//  NextMovies
//
//  Created by Tiago Chaves on 09/11/18.
//  Copyright © 2018 Next. All rights reserved.
//

import Foundation

enum ItemType:String,Codable {
    
    case movie  = "movie"
    case list   = "list"
}

struct Movie:Codable{
    
    let title       :String
    let categories  :[String]?
    let duration    :String?
    let rating      :Double?
    let summary     :String?
    let image       :String?
    let itemType    :ItemType?
    let items       :[Movie]?
    
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
}
