//
//  MovieListViewModel.swift
//  OMDBMovies
//
//  Created by Priyanka Kaushal on 16/08/25.
//

import Foundation
import Combine

enum MovieSearchViewModelState {
    case empty
    case loading
    case loaded
    case error(String)
}

class MovieListViewModel: ObservableObject {
    
    @Published private(set) var state: MovieSearchViewModelState = .empty
    
    @Published private(set) var movies: [MovieListItem] = []
    
    private var topRatedMovies: [MovieListItem] = []
    
    private(set) var searchSubject = CurrentValueSubject<String, Never>("")
    
    private let movieRepository: MoviesRepositoryProtocol
    
    private var subCancellables: Set<AnyCancellable> = []
    
    init(movieRepository: MoviesRepositoryProtocol) {
        self.movieRepository = movieRepository
        self.setupSearchPub()
    }
    
    func findMovies(query:String) {
        searchSubject.send(query)
    }
    
    private func setupSearchPub() {
        searchSubject
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .sink { [weak self] searchQuery in
                self?.fetchMovies(searchQuery: searchQuery)
            }.store(in: &subCancellables)
    }
    
    private func fetchMovies(searchQuery: String) {
        if searchQuery.isEmpty {
            self.loadTopRatedMovies()
            return
        }
        
        self.state = .loading
        
        self.movieRepository.fetchMovies(searchQuery: searchQuery)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    print("Fetch movies finished")
                case .failure(let error):
                    self?.movies.removeAll()
                    self?.state = .error(error.localizedDescription)
                    print(error)
                }
            } receiveValue: { [weak self] fetchedMovies in
                self?.state = .loaded
                self?.movies = fetchedMovies
            }.store(in: &subCancellables)
    }
    
    func loadTopRatedMovies() {
        if self.topRatedMovies.isEmpty {
            self.state = .loading
            Task {
                let fetchedMovies = try? await self.movieRepository.fetchTopRatedMovies()
                self.topRatedMovies = fetchedMovies ?? []
                await MainActor.run {
                    self.state = .loaded
                    self.movies = self.topRatedMovies
                }
            }
        } else {
            self.state = .loaded
            self.movies = self.topRatedMovies
        }
    }
}

#if DEBUG
extension MovieListViewModel {
    
    func testable_fetchMovies(searchQuery: String) {
        self.fetchMovies(searchQuery: searchQuery)
    }
}
#endif
