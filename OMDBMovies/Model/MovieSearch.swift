//
//  MovieSearch.swift
//  OMDBMovies
//
//  Created by Priyanka Kaushal on 16/08/25.
//

import Foundation

struct MovieSearch: Decodable {
    var search:[Movies]
    
    enum CodingKeys: String, CodingKey {
        case search = "Search"
    }
}
 
struct Movies: Decodable, Identifiable {
    let imdbID: String
    let title:String
    var year:String?
    var type:String?
    var poster:URL?
    
    var id:String {
        imdbID
    }
    
    enum CodingKeys: String, CodingKey {
        case imdbID
        case title = "Title"
        case year = "Year"
        case type = "Type"
        case poster = "Poster"
    }
}
