//
//  ContentView.swift
//  OMDBMovies
//
//  Created by Priyanka Kaushal on 15/08/25.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel: MovieSearchViewModel
    
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
                                .frame(width: 75, height: 75)
                        case .success(let image):
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 75, height: 75)
                        default:
                            ProgressView()
                        }
                    }
                    Text(movie.title)
                }
            }
            .listStyle(.plain)
            .overlay(content: {
                if viewModel.movies.isEmpty {
                    Text("No movies found")
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
    ContentView(viewModel: MovieSearchViewModel(movieService: MockMovieService()))
}
