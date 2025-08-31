//
//  MovieSearchViewModelTests.swift
//  OMDBMoviesTests
//
//  Created by Priyanka Kaushal on 26/08/25.
//

import XCTest
import Combine
@testable import OMDBMovies

final class MovieSearchViewModelTests: XCTestCase {
    
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        cancellables = []
    }
    
    override func tearDown() {
        cancellables = nil
    }

    func testFetchMovies_Success() {
        // Arrange
        let vm = MovieSearchViewModel(movieService: MockMovieService())
        
        let expectation = XCTestExpectation(description: "Movies updated")
        
        vm.$movies
            .dropFirst() // skip initial empty []
            .sink { movies in
                XCTAssertEqual(movies.count, 10, "Expected Movies 10")
                XCTAssertEqual(movies.first?.title, "Mission: Impossible - Ghost Protocol", "Title doesn't match")
                XCTAssertEqual(movies.last?.title, "The Mission", "Title doesn't match")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        // Act
        vm.testable_fetchMovies(searchQuery: "Mission")
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testFetchMovies_Failure() {
        // Arrange
        let vm = MovieSearchViewModel(movieService: MockMovieService(returnMovies: false))
        
        let expectation = XCTestExpectation(description: "Movies updated")
        
        vm.$movies
            .dropFirst() // skip initial empty []
            .sink { movies in
                XCTAssertEqual(movies.count, 0, "Movies array should be empty")
                XCTAssertFalse(vm.loadingComleted)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        // Act
        vm.testable_fetchMovies(searchQuery: "Mission")
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testFindMovies() {
        // Arrange
        let vm = MovieSearchViewModel(movieService: MockMovieService())
        
        let expectation = XCTestExpectation(description: "Movies updated")
        
        let expectedQuery = "Mission"
        
        //Assert
        vm.searchSubject
            .dropFirst()
            .sink { query in
                XCTAssertEqual(query, expectedQuery, "Expected query shall Mission")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        // Act
        vm.findMovies(query: expectedQuery)
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    
}


