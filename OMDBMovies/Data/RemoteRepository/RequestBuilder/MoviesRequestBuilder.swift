//
//  MoviesRequestBuilder.swift
//  OMDBMovies
//
//  Created by Priyanka Kaushal on 20/08/25.
//

import Foundation

enum MoviesRequestBuilder {
    case topRated
    case search(Encodable)
    case details(String, Encodable)
}

extension MoviesRequestBuilder: URLRequestBuilder {
    
    var httpMethod:HTTPMethod {
        switch self {
        case .search(_):
            return .GET
        case .details(_, _):
            return .GET
        case .topRated:
            return .GET
        }
    }

    var requestBody:Data? {
        switch self {
        case .search(_):
            return nil
        case .details(_, _):
            return nil
        case .topRated:
            return nil
        }
    }

    var endPoint:String {
        switch self {
        case .search(let searchQuery):
            return "search/movie".appending(searchQuery.getURLQuery())
        case .details(let movieId, let searchQuery):
            return "movie/\(movieId)?".appending(searchQuery.getURLQuery())
        case .topRated:
            return "movie/top_rated"
        }
    }
}
