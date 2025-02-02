//
//  EndpointProtocol.swift
//  weather-app
//
//  Created by Sandesh Naik on 31/12/22.
//

import Foundation

protocol Endpoint {
    var scheme: String { get }
    var baseURL: String { get }
    var path: String { get }
    var queryItems: [URLQueryItem] { get }
    var method: String { get }
    func generateURLRequest() -> URLRequest?
}
