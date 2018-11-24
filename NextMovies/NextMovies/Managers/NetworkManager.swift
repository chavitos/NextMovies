//
//  NetworkManager.swift
//  NextMovies
//
//  Created by Tiago Chaves on 09/11/18.
//  Copyright © 2018 Next. All rights reserved.
//

import Foundation
import Alamofire

public enum MovieNextRequests: URLRequestConvertible {
//    https://itunes.apple.com/search?media=movie&entity=movie&term=Deadpool 2
    static let baseURLPath = "https://itunes.apple.com"
    
    case getMovieInfo(String)
    
    var method: HTTPMethod {
        switch self {
        case .getMovieInfo:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getMovieInfo:
            return "/search"
        }
    }
    
    var parameters: [String: Any] {
        switch self {
        case .getMovieInfo(let title):
            return ["media": "movie","entity":"movie","term":title]
        }
    }
    
    public func asURLRequest() throws -> URLRequest {
        
        let url = try MovieNextRequests.baseURLPath.asURL()
        var request = URLRequest(url: url.appendingPathComponent(path))
        
        request.httpMethod = method.rawValue
        request.timeoutInterval = TimeInterval(10 * 1000)
        
        return try URLEncoding.default.encode(request, with: parameters)
    }
}

class NetworkManager {
    
    class func getData(ofURL url:URLRequestConvertible, callback:@escaping (Data?,Error?)->Void) {
        
        Alamofire.request(url).validate().responseJSON { response in
            
            NSLog("Requesting: \(url.urlRequest!)")
            
            switch response.result {
            case .success:
                let data = response.data
                NSLog("Request successed!")
                callback(data, nil)
            case .failure(let error):
                NSLog("Request failed! \(error.localizedDescription)")
                callback(nil, error)
            }
        }
    }
}
