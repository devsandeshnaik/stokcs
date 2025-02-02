//
//  Stock.swift
//  stocks
//
//  Created by Sandesh Naik on 01/02/25.
//

import Foundation
import SwiftData

@Model
final class Stock: Codable {
    @Attribute(.unique) var sid: String
    var price: Double
    var close: Double
    var change: Double
    var high: Double
    var low: Double
    var volume: Int
    var date: String
    
    enum CodingKeys: String, CodingKey {
        case sid, price, close, change, high, low, volume, date
    }
    
    init(sid: String, price: Double, close: Double, change: Double, high: Double, low: Double, volume: Int, date: String) {
        self.sid = sid
        self.price = price
        self.close = close
        self.change = change
        self.high = high
        self.low = low
        self.volume = volume
        self.date = date
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.sid = try container.decode(String.self, forKey: .sid)
        self.price = try container.decode(Double.self, forKey: .price)
        self.close = try container.decode(Double.self, forKey: .close)
        self.change = try container.decode(Double.self, forKey: .change)
        self.high = try container.decode(Double.self, forKey: .high)
        self.low = try container.decode(Double.self, forKey: .low)
        self.volume = try container.decode(Int.self, forKey: .volume)
        self.date = try container.decode(String.self, forKey: .date)
    }
    
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(sid, forKey: .sid)
        try container.encode(price, forKey: .price)
        try container.encode(close, forKey: .close)
        try container.encode(change, forKey: .change)
        try container.encode(high, forKey: .high)
        try container.encode(low, forKey: .low)
        try container.encode(volume, forKey: .volume)
        try container.encode(date, forKey: .date)
    }
    
    
}
