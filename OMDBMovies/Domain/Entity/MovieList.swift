//
//  MovieListItem.swift
//  OMDBMovies
//
//  Created by Priyanka Kaushal on 27/09/25.
//

import Foundation

struct MovieListItem: Identifiable {
    
    var id:Int {
        tmdId
    }
    
    let tmdId: Int
    let title: String
    var posterPath: String?
    
    var posterImgURl: URL? {
        if let posterPath, !posterPath.isEmpty {
            return URL(string: "\(URLConstants.imgURLTmdb1280)\(posterPath)")!
        } else {
            return nil
        }
    }
}

extension MovieDTO {
    func toDomain() -> MovieListItem {
        return MovieListItem(tmdId: self.tmdId ?? 0, title: self.title ?? "", posterPath: self.posterPath)
    }
}
