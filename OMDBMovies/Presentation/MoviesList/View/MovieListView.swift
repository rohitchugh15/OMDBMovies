//
//  ContentView.swift
//  OMDBMovies
//
//  Created by Priyanka Kaushal on 15/08/25.
//

import SwiftUI

struct MovieListView: View {
    
    @StateObject var viewModel: MovieListViewModel
    
    @State private var searchQuery: String = ""
    
    var body: some View {
        NavigationStack {
            List(viewModel.movies) { movie in
                HStack {
                    AsyncImage(url: movie.poster) { phase in
                        switch phase {
                        case .empty, .failure:
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                                .cornerRadius(40)
                        case .success(let image):
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80, height: 80)
                                .cornerRadius(40)
                        default:
                            ProgressView()
                        }
                    }
                    Text(movie.title)
                }
            }
            .listStyle(.plain)
            .overlay(content: {
                switch viewModel.state {
                case .loading:
                    ProgressView("Loading...")
                case .error(let errorMessage):
                    Text(errorMessage)
                case .empty:
                    Text("Please search by movie names")
                case .loaded:
                    if viewModel.movies.isEmpty {
                        Text("No movies found")
                    }
                }
            })
            .searchable(text: $searchQuery)
            .onChange(of: searchQuery) {
                viewModel.findMovies(query: searchQuery)
            }
        }
    }
}

#Preview {
    MovieListView(viewModel: MovieListViewModel(movieRepository: MockMoviesRepository()))
}
