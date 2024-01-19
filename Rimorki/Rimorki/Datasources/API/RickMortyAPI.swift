//
//  RickMortyAPI.swift
//  Rimorki
//
//  Created by Bambang Tri Rahmat Doni on 20/01/24.
//

import Combine
import Foundation

enum APIError: Error, LocalizedError {
    case unknown
    case apiError(reason: String)
    case parserError(reason: String)
    case  networkError(from: URLError)
    
    var errorDescription: String? {
        switch self {
        case .unknown:
            return "Unknown error"
        case .apiError(let reason), .parserError(let reason):
            return reason
        case .networkError(let from):
            return from.localizedDescription
        }
    }
}

final class RickMortyAPI {
    func fetchAllCharacters(withPage page: Int = 1) -> AnyPublisher<RickMortyAPIModel, Error> {
        let url = URL(string: "https://rickandmortyapi.com/api/character/?page=\(page)")!
        let request = URLRequest(url: url)
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .print()
            .throttle(for: 1.0, scheduler: DispatchQueue.global(qos: .background), latest: true)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw APIError.unknown
                }
                if (httpResponse.statusCode == 401) {
                    throw APIError.apiError(reason: "Unauthorized");
                }
                if (httpResponse.statusCode == 403) {
                    throw APIError.apiError(reason: "Resource forbidden");
                }
                if (httpResponse.statusCode == 404) {
                    throw APIError.apiError(reason: "Resource not found");
                }
                if (405..<500 ~= httpResponse.statusCode) {
                    throw APIError.apiError(reason: "Client error");
                }
                if (500..<600 ~= httpResponse.statusCode) {
                    throw APIError.apiError(reason: "Server error");
                }
                
                return data
            }
            .mapError { error in
                // if it's our kind of error already, we can return it directly
                if let error = error as? APIError {
                    return error
                }
                // if it is a URLError, we can convert it into our more general error kind
                if let urlerror = error as? URLError {
                    return APIError.networkError(from: urlerror)
                }
                // if all else fails, return the unknown error condition
                return APIError.unknown
            }
            .decode(type: RickMortyAPIModel.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
