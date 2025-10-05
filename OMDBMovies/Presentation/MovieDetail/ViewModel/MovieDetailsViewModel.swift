//
//  MovieDetailsViewModel.swift
//  OMDBMovies
//
//  Created by Priyanka Kaushal on 01/09/25.
//

import Foundation

enum MovieDetailsViewModelState {
    case loading
    case loaded
    case error(String)
}

class MovieDetailsViewModel: ObservableObject {
    
    @MainActor @Published private(set) var state: MovieSearchViewModelState = .loading
    
    @MainActor @Published private(set) var movie: MovieDetails?
    
    private let tmdMovieId: String
    
    private let movieRepository: MoviesRepositoryProtocol
    
    init(movieId: String, movieRepository: MoviesRepositoryProtocol) {
        self.movieRepository = movieRepository
        self.tmdMovieId = movieId
    }
    
    func fetchMovieDetail() async {
        guard !tmdMovieId.isEmpty else {
            return
        }
        
        await MainActor.run { self.state = .loading }
        do {
            let movie = try await self.movieRepository.fetchMovieDetail(tmdMovieId)
            
            await MainActor.run {
                self.movie = movie
                self.state = .loaded
            }
        } catch {
            await MainActor.run {
                self.state = .error("Failed to fetch movie details")
            }
        }
    }
}
