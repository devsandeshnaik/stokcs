//
//  WishlistScreenVM.swift
//  stocks
//
//  Created by Sandesh Naik on 02/02/25.
//

import Foundation
import Combine

final class WishlistScreenVM: ObservableObject {
    
    var stocksService: StocksServiceProtocol
    
    @Published var stocks: [Stock] = []
    @Published var networkError: NetworkError?
    
    init(stocksService: StocksServiceProtocol) {
        self.stocksService = stocksService
        stocksService.stocks
            .receive(on: DispatchQueue.main)
            .assign(to: &$stocks)
        
        stocksService.networkError
            .receive(on: DispatchQueue.main)
            .assign(to: &$networkError)
    }
    
}
