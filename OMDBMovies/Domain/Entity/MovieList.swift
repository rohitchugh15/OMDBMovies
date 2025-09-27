//
//  MovieListItem.swift
//  OMDBMovies
//
//  Created by Priyanka Kaushal on 27/09/25.
//

import Foundation

struct MovieListItem: Identifiable {
    
    var id:String {
        imdbID
    }
    
    var imdbID: String
    var title: String
    var poster: URL?
}
