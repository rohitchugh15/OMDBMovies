//
//  NetworkError.swift
//  OMDBMovies
//
//  Created by Priyanka Kaushal on 20/08/25.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case transport(Error)
    case server(status: Int, body: Data?)
    case decoding(Error)
}
