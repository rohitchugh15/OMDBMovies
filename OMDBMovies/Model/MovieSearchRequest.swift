//
//  MovieSearchRequest.swift
//  OMDBMovies
//
//  Created by Priyanka Kaushal on 16/08/25.
//

import Foundation

struct MovieSearchRequest: Encodable {
    var searchQuery: String
    private let apiKey: String = "6cd9bade"
    
    enum CodingKeys: String, CodingKey {
        case searchQuery = "s"
        case apiKey
    }
}
