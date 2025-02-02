//
//  StocksEndpoint.swift
//  weather-app
//
//  Created by Sandesh Naik on 1/2/25
//

import Foundation
import MapKit

enum StocksEndpoint  {
    case getStocks
    case getDetails(String)
}

//'https://api.tickertape.in/stocks/quotes?sids=RELI%2CTCS%2CITC%2CHDBK%2CINFY
extension StocksEndpoint: Endpoint {
    
    var scheme: String {
        return "https"
    }
    var baseURL: String {
        return "api.tickertape.in"
    }
    
    var path: String {
        return "/stocks/quotes"
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .getStocks:
            return [URLQueryItem(name: "sids", value: "RELI,TCS,ITC,HDBK,INFY")]
        case .getDetails(let sid) :
            return [URLQueryItem(name: "sids", value: sid)]
        }
    }
    
    var method: String {
        return "get"
    }
    
    func generateURLRequest() -> URLRequest? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = baseURL
        components.path = path
        components.queryItems = queryItems
        
        guard let url = components.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = method
        return request
    }
}
