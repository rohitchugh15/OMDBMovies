//
//  RemoteMoviesRepository.swift
//  OMDBMovies
//
//  Created by Priyanka Kaushal on 27/09/25.
//

import Foundation
import Combine

class RemoteMoviesRepository: MoviesRepositoryProtocol {
    
    func fetchTopRatedMovies() async throws -> [MovieListItem] {
        let topMoviesURLRequest = MoviesRequestBuilder.topRated.urlRequest()
        
        do {
            let movieResults: MovieResultsDTO = try await RequestHandlerAsync().sendRequest(topMoviesURLRequest, as: MovieResultsDTO.self)
            return movieResults.movies.map({$0.toDomain()})
        } catch {
            throw error
        }
    }
    
    func fetchMovies(searchQuery: String) -> AnyPublisher<[MovieListItem], NetworkError> {
        let movieSerchRequest = MovieSearchRequestDTO(query: searchQuery)
        
        let movieSearchURLRequest = MoviesRequestBuilder.search(movieSerchRequest).urlRequest()
        
        return RequestHandler()
            .sendRequest(urlRequest: movieSearchURLRequest, responseType: MovieResultsDTO.self)
            .map { $0.movies.map({$0.toDomain()}) }
            .eraseToAnyPublisher()
    }
    
    func fetchMovieDetail(_ movieId: String) async throws -> MovieDetails {
        let movieDetailRequest = MovieDetailRequestDTO()
        
        let movieDetailURLRequest = MoviesRequestBuilder.details(movieId, movieDetailRequest).urlRequest()
        
        do {
            return try await RequestHandlerAsync().sendRequest(movieDetailURLRequest, as: MovieDetailDTO.self).toDomain()
        } catch {
            throw error
        }
    }
}
