//
//  RequestHandler.swift
//  OMDBMovies
//
//  Created by Priyanka Kaushal on 15/08/25.
//

import Foundation
import Combine

class RequestHandler {
    
    func sendRequest<T:Decodable>(urlRequest: URLRequest, responseType: T.Type) -> AnyPublisher<T, NetworkError> {
        do {
            return URLSession.shared.dataTaskPublisher(for: urlRequest)
                .tryMap { output -> Data in
                    guard let response = output.response as? HTTPURLResponse else {
                        return output.data
                    }
                    guard (200...299).contains(response.statusCode) else {
                        throw NetworkError.server(status: response.statusCode, body: output.data)
                    }
                    return output.data
                }
                .decode(type: T.self, decoder: JSONDecoder())
                .receive(on: DispatchQueue.main)
                .mapError { error -> NetworkError in
                    switch error {
                    case is DecodingError:
                        return .decoding(error)
                    case let apiError as NetworkError:
                        return apiError
                    default:
                        return .transport(error)
                    }
                }
                .eraseToAnyPublisher()
        } catch let error as NetworkError {
            return Fail(error: error).eraseToAnyPublisher()
        } catch {
            return Fail(error: .transport(error)).eraseToAnyPublisher()
        }
    }
}
