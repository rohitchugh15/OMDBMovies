//
//  MoviesTopRatedDTO.swift
//  OMDBMovies
//
//  Created by Priyanka Kaushal on 05/10/25.
//

//MARK: MoviesTopRatedDTO
struct MovieResultsDTO: Decodable {
    
    var page: Int?
    var movies: [MovieDTO]
    var totalPages: Int?
    var totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page
        case movies = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

//MARK: MovieDTO
struct MovieDTO: Decodable {
    
    var tmdId: Int?
    var adult: Bool?
    var backdropPath: String?
    var genreIDS: [Int]?
    var originalLanguage: String?
    var originalTitle: String?
    var overview: String?
    var popularity: Double?
    var posterPath: String?
    var releaseDate: String?
    var title: String?
    var video: Bool?
    var voteAverage: Double?
    var voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case tmdId = "id"
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
