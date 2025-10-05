//
//  MovieRequestDTO.swift
//  OMDBMovies
//
//  Created by Priyanka Kaushal on 16/08/25.
//

import Foundation

//MARK: MovieSearchRequestDTO
struct MovieSearchRequestDTO: Encodable {
    var query: String
}

//MARK: MovieDetailRequestDTO
struct MovieDetailRequestDTO: Encodable {
    private let apiKey: String = "be5a6ad187c218e1ad9a77a3b55824d8"
    
    enum CodingKeys: String, CodingKey {
        case apiKey = "api_key"
    }
}
