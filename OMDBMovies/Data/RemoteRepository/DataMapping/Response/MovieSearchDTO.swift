//
//  MovieSearch.swift
//  OMDBMovies
//
//  Created by Priyanka Kaushal on 16/08/25.
//

import Foundation

struct MovieSearchDTO: Decodable {
    var search:[MovieDTO]
    
    enum CodingKeys: String, CodingKey {
        case search = "Search"
    }
}
 
struct MovieDTO: Decodable {
    let imdbID: String
    let title:String
    var year:String?
    var type:String?
    var poster:URL?
    
    enum CodingKeys: String, CodingKey {
        case imdbID
        case title = "Title"
        case year = "Year"
        case type = "Type"
        case poster = "Poster"
    }
}

extension MovieDTO {
    func toDomain() -> MovieListItem {
        return MovieListItem(imdbID: self.imdbID, title: self.title, poster: self.poster)
    }
}
