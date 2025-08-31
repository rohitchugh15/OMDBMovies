//
//  MovieService.swift
//  OMDBMovies
//
//  Created by Priyanka Kaushal on 16/08/25.
//

import Foundation
import Combine

protocol MovieServiceProtocol {
    func fetchMovies(searchQuery: String) -> AnyPublisher<MovieSearch, NetworkError>
}

class MovieService: MovieServiceProtocol {
    
    func fetchMovies(searchQuery: String) -> AnyPublisher<MovieSearch, NetworkError> {
        let movieSerchRequest = MovieSearchRequest(searchQuery: searchQuery)
        
        let movieSearchURLRequest = MoviesRequestBuilder.searchMovies(movieSerchRequest).urlRequest()
        
        return RequestHandler().sendRequest(urlRequest: movieSearchURLRequest, responseType: MovieSearch.self)
    }
}
