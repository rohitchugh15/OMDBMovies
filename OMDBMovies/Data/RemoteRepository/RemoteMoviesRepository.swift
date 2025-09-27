//
//  RemoteMoviesRepository.swift
//  OMDBMovies
//
//  Created by Priyanka Kaushal on 27/09/25.
//

import Foundation
import Combine

class RemoteMoviesRepository: MoviesRepositoryProtocol {
    
    func fetchMovies(searchQuery: String) -> AnyPublisher<[MovieListItem], NetworkError> {
        let movieSerchRequest = MovieSearchRequestDTO(searchQuery: searchQuery)
        
        let movieSearchURLRequest = MoviesRequestBuilder.searchMovies(movieSerchRequest).urlRequest()
        
        return RequestHandler()
            .sendRequest(urlRequest: movieSearchURLRequest, responseType: MovieSearchDTO.self)
            .map { $0.search.map { $0.toDomain() } }
            .eraseToAnyPublisher()
    }
}
