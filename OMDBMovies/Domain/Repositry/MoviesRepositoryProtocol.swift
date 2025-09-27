//
//  MoviesRepositoryProtocol.swift
//  OMDBMovies
//
//  Created by Priyanka Kaushal on 16/08/25.
//

import Foundation
import Combine

protocol MoviesRepositoryProtocol {
    func fetchMovies(searchQuery: String) -> AnyPublisher<[MovieListItem], NetworkError>
}
