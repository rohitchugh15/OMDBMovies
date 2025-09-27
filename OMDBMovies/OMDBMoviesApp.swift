//
//  OMDBMoviesApp.swift
//  OMDBMovies
//
//  Created by Priyanka Kaushal on 15/08/25.
//

import SwiftUI

@main
struct OMDBMoviesApp: App {
    var body: some Scene {
        WindowGroup {
            MovieListView(viewModel: MovieListViewModel(movieRepository: RemoteMoviesRepository()))
        }
    }
}
