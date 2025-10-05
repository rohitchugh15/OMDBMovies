//
//  MovieDetail.swift
//  OMDBMovies
//
//  Created by Priyanka Kaushal on 01/09/25.
//

import Foundation

struct MovieDetails {
    
    let title: String
    let overview: String
    let backdropPath: String
    let tagline: String?

    var backdropImageURl: URL? {
        guard !backdropPath.isEmpty else { return nil }
        return URL(string: "\(URLConstants.imgURLTmdb1280)\(backdropPath)")!
    }
}

extension MovieDetailDTO {
    func toDomain() -> MovieDetails {
        return MovieDetails(title: self.title, overview: self.overview, backdropPath: self.backdropPath, tagline: self.tagline)
    }
}
