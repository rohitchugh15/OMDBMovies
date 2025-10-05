//
//  MovieDetailsView.swift
//  OMDBMovies
//
//  Created by Priyanka Kaushal on 01/09/25.
//

import SwiftUI

struct MovieDetailsView: View {
    
    @StateObject var viewModel: MovieDetailsViewModel
    
    @State private var showSheet = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                //Header
                ZStack(alignment: .bottom) {
                    AsyncImage(url: viewModel.movie?.backdropImageURl) { phase in
                        switch phase {
                        case .empty, .failure:
                            Image(systemName: "photo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.width)
                        case .success(let image):
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.width)
                        default:
                            ProgressView()
                        }
                    }
                    Text(viewModel.movie?.title ?? "")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                        .padding()
                }
                Text(viewModel.movie?.tagline ?? "")
                    .font(.callout)
                    .foregroundStyle(.gray)
                    .padding()
                Text(viewModel.movie?.overview ?? "")
                    .font(.subheadline)
                    .foregroundStyle(.black)
                    .padding()
                    .onTapGesture {
                        withAnimation {
                            showSheet.toggle()
                        }
                    }
            }
        }
        .task {
            await viewModel.fetchMovieDetail()
        }
        .sheet(isPresented: $showSheet) {
            ThirdView()
                .transition(.move(edge: .bottom))
        }
    }
}

struct ThirdView: View {
    var body: some View {
        ZStack {
            Text("Cart View")
                .font(.largeTitle)
        }
        .backgroundStyle(.cyan)
    }
}

#Preview {
    MovieDetailsView(viewModel: MovieDetailsViewModel(movieId: "424", movieRepository: MockMoviesRepository()))
}
