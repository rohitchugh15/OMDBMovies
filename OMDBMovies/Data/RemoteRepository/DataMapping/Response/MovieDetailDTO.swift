//
//  MovieDetail.swift
//  OMDBMovies
//
//  Created by Priyanka Kaushal on 28/09/25.
//

struct MovieDetailDTO: Decodable {
    
    let title: String
    let overview: String
    let backdropPath: String
    let tagline: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case overview
        case backdropPath = "backdrop_path"
        case tagline
    }
}
