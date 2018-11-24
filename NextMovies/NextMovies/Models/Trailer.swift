//
//  Trailer.swift
//  NextMovies
//
//  Created by Tiago Chaves on 24/11/18.
//  Copyright © 2018 Next. All rights reserved.
//

import Foundation

struct TrailerResult:Codable {
    
    var results:[Trailer]?
    
    var trailer:String {
        
        if let results = self.results, results.count > 0 {
            
            return results.first?.previewUrl ?? ""
        }
        
        return ""
    }
}

struct Trailer:Codable {
    
    var previewUrl:String?
}
