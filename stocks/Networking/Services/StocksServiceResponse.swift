//
//  StocksServiceResponse.swift
//  stocks
//
//  Created by Sandesh Naik on 01/02/25.
//

import Foundation

struct StocksServiceResponse: Codable {
    let success: Bool
    let data: [Stock]
}
