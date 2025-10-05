//
//  URLRequestBuilder.swift
//  OMDBMovies
//
//  Created by Priyanka Kaushal on 16/08/25.
//

import Foundation

//MARK: HTTPMethod
enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
    case PATCH
}

//MARK: URLRequestBuilder
protocol URLRequestBuilder {
    var baseURL: String { get }
    
    var endPoint: String { get }
    
    var httpMethod: HTTPMethod { get }
    
    var headers: [String:String]? { get }
    
    var requestBody: Data? { get }
}

extension URLRequestBuilder {
    
    var baseURL: String {
        return URLConstants.baseURL
    }
    
    var headers: [String : String]? {
        return [
            "accept" : "application/json",
            "content-type" : "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiZTVhNmFkMTg3YzIxOGUxYWQ5YTc3YTNiNTU4MjRkOCIsIm5iZiI6MTc1ODk5ODcyNS40NzIsInN1YiI6IjY4ZDgzMGM1Njg2YmNhMzc3ZjJkZTEwYyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.kXwsLllnNfvwmFxGrkYgqocoBe7M_FC4yLSD0ZVpwLM"
        ]
    }
    
    func urlRequest() -> URLRequest {
        var urlRequest = URLRequest(url: URL(string: self.baseURL.appending(endPoint))!)
        
        urlRequest.httpMethod = self.httpMethod.rawValue
        urlRequest.httpBody = self.requestBody
        urlRequest.allHTTPHeaderFields = self.headers
        
        return urlRequest
    }
}
