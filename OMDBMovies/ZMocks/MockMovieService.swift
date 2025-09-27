//
//  MockMovieService.swift
//  OMDBMovies
//
//  Created by Priyanka Kaushal on 25/08/25.
//

import Foundation
import Combine

class MockMoviesRepository: MoviesRepositoryProtocol {
    
    private(set) var returnMovies: Bool
    
    init(returnMovies: Bool = true) {
        self.returnMovies = returnMovies
    }
    
    func fetchMovies(searchQuery: String) -> AnyPublisher<[MovieListItem], NetworkError> {
        if !returnMovies {
            return Fail(error: NetworkError.invalidResponse)
                .eraseToAnyPublisher()
        }
        
        guard let jsonData = Bundle(for: Self.self).dataFromJson(fileName: "MovieSearchMockResponse") else {
            return Fail(error: NetworkError.invalidResponse)
                .eraseToAnyPublisher()
        }
        
        do {
            let decoder = JSONDecoder()
            let movies = try decoder.decode(MovieSearchDTO.self, from: jsonData).search.map({$0.toDomain()})
            return Just(movies)
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: NetworkError.decoding(error))
                .eraseToAnyPublisher()
        }
    }
}
