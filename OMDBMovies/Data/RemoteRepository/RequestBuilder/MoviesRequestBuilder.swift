//
//  MoviesRequestBuilder.swift
//  OMDBMovies
//
//  Created by Priyanka Kaushal on 20/08/25.
//

import Foundation

enum MoviesRequestBuilder {
    case searchMovies(Encodable)
}

extension MoviesRequestBuilder: URLRequestBuilder {
    
    var httpMethod:HTTPMethod {
        switch self {
        case .searchMovies(_):
            return .GET
        }
    }

    var requestBody:Data? {
        switch self {
        case .searchMovies(_):
            return nil
        }
    }

    var endPoint:String {
        switch self {
        case .searchMovies(let searchQuery):
            return "?".appending(searchQuery.getURLQuery())
        }
    }
}

