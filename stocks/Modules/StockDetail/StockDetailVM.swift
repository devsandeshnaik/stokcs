//
//  StockDetailVM.swift
//  stocks
//
//  Created by Sandesh Naik on 02/02/25.
//

import Foundation
import Combine

class StockDetailVM: ObservableObject {
    
    private var stocksService: StocksServiceProtocol
    private let stock: Stock
    private var cancellables = Set<AnyCancellable>()
    private let pollingInterVal: TimeInterval = 5
    
    @Published var stockHistory: [Stock]
    @Published var error: Error?


    init (stock: Stock, stockService: StocksServiceProtocol) {
        self.stock = stock
        self.stocksService = stockService
        stockHistory = [stock]
    }
    
    func startPolling() {
        Timer.publish(every: 5, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                Task {
                    await self?.getDetail()
                }
            }
            .store(in: &cancellables)
    }
    
    private func getDetail() async {
        await stocksService.getStockDetail(sid: stock.sid)
            .mapError { error in
                self.error = error
                return error
            }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { stock in
                guard stock != nil else { return }
                self.stockHistory += [stock!]
            }
            .store(in: &cancellables)
    }
    
    deinit {
        cancellables.removeAll()
    }
}
