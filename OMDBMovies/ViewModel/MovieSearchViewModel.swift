//
//  MovieSearchViewModel.swift
//  OMDBMovies
//
//  Created by Priyanka Kaushal on 16/08/25.
//

import Foundation
import Combine

class MovieSearchViewModel: ObservableObject {
    
    @Published private(set) var movies: [Movies] = []
    
    @Published private(set) var loadingComleted: Bool = false
    
    private(set) var searchSubject = CurrentValueSubject<String, Never>("")
    
    private let movieService: MovieServiceProtocol
    
    private var subCancellables: Set<AnyCancellable> = []
    
    init(movieService: MovieServiceProtocol) {
        self.movieService = movieService
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
        self.loadingComleted = false
        
        self.movieService.fetchMovies(searchQuery: searchQuery)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    self?.loadingComleted = true
                case .failure(let error):
                    self?.movies = []
                    print(error)
                }
            } receiveValue: { [weak self] movieSearch in
                self?.movies = movieSearch.search
            }.store(in: &subCancellables)
    }
}

#if DEBUG
extension MovieSearchViewModel {
    
    func testable_fetchMovies(searchQuery: String) {
        self.fetchMovies(searchQuery: searchQuery)
    }
}
#endif
