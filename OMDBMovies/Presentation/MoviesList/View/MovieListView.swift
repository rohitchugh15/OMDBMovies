//
//  ContentView.swift
//  OMDBMovies
//
//  Created by Priyanka Kaushal on 15/08/25.
//

import SwiftUI

enum NavigationPaths: Hashable {
    case navigationDetail(String)
}

struct MovieListView: View {
    
    @StateObject var viewModel: MovieListViewModel
    
    @State private var searchQuery: String = ""
    
    @State private var paths: [NavigationPaths] = []
    
    var body: some View {
        NavigationStack(path: $paths) {
            List(viewModel.movies) { movie in
                HStack {
                    AsyncImage(url: movie.posterImgURl) { phase in
                        switch phase {
                        case .empty, .failure:
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                                .cornerRadius(40)
                        case .success(let image):
                            image.resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 80, height: 80)
                                .cornerRadius(40)
                        default:
                            ProgressView()
                        }
                    }
                    Text(movie.title)
                }.onTapGesture {
                    self.paths.append(.navigationDetail("\(movie.id)"))
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
            .navigationDestination(for: NavigationPaths.self) { item in
                switch item {
                case .navigationDetail(let movieId):
                    MovieDetailsView(viewModel: MovieDetailsViewModel(movieId: movieId, movieRepository: RemoteMoviesRepository()))
                default:
                    ThirdView()
                }
            }
        }
    }
}

#Preview {
    MovieListView(viewModel: MovieListViewModel(movieRepository: MockMoviesRepository()))
}
