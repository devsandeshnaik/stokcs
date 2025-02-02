//
//  APIClient.swift
//  weather-app
//
//  Created by Sandesh Naik on 31/12/22.
//

import Foundation
import Combine

enum NetworkError: Error {
    case unabeToGenerateRequest
    case invalidEndpoint
    case parsingError
}

/// A protocol for requesting an API
protocol APIClientRequestable {
    associatedtype Endpoint
    /// Designated request-making method
    /// - Parameter target: TargetType enum value for API
    /// - Returns: `AnyPublisher<Model, NetworkError>`
    func request<Model: Codable>(for endpoint: Endpoint) async -> AnyPublisher<Model, NetworkError>
}

final class APIClient<T: Endpoint>: APIClientRequestable {
    
    private var session: URLSession = .shared
    
    func request<Model: Codable>(for endpoint: T) async -> AnyPublisher<Model, NetworkError> {
        guard let request = endpoint.generateURLRequest() else {
            return Fail(error: NetworkError.unabeToGenerateRequest).eraseToAnyPublisher()
        }
        print(request)
        return session.dataTaskPublisher(for: request)
            .mapError { _ in NetworkError.invalidEndpoint }
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw NetworkError.invalidEndpoint
                }
                return data
            }
            .decode(type: Model.self, decoder: JSONDecoder())
            .mapError { err in
                print("xxx \(err)")
                return NetworkError.parsingError
            }
            .eraseToAnyPublisher()
    }
}
