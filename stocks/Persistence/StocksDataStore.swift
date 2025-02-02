//
//  StocksDataController.swift
//  stocks
//
//  Created by Sandesh Naik on 01/02/25.
//

import SwiftData
import Foundation
import SwiftUI

protocol StocksDataStoreProtocol {
    func addNewStock(_ stock: Stock)
    func deleteStock(_ stock: Stock)
    var stocks: [Stock] { get }
}

final class StockDataStore: ObservableObject, StocksDataStoreProtocol {
    private let modelContext: ModelContext
    @Published var stocks: [Stock] = []

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        fetchStocks()
    }
    
    /// Saves new Stock entity to persistance store
    func addNewStock(_ stock: Stock) {
        modelContext.insert(stock)
        fetchStocks()
    }
    
    /// Deletes Stock entity to persistance store
    func deleteStock(_ stock: Stock) {
        modelContext.delete(stock)
        fetchStocks()
    }
    
    /// Fectches all the Stocks entities from persistance store
    func fetchStocks() {
        try? modelContext.save()
        let descriptor = FetchDescriptor<Stock>(sortBy: [])
        stocks = (try? modelContext.fetch(descriptor)) ?? []
    }
}
