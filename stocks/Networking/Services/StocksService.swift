//
//  StocksService.swift
//  stocks
//
//  Created by Sandesh Naik on 01/02/25.
//

import Foundation
import Combine

protocol StocksServiceProtocol {
    var stocks: Published<[Stock]>.Publisher { get }
    var networkError: Published<NetworkError?>.Publisher { get }
    
    //for fetching details on single stocks
    func getStockDetail(sid: String) async -> AnyPublisher<Stock?, NetworkError>
}

final class StocksService: StocksServiceProtocol {
    
    private var cancellables = Set<AnyCancellable>()
    
    private let client = APIClient<StocksEndpoint>()
    
    @Published var _stocks: [Stock] = []
    @Published var _networkError: NetworkError?
    
    var stocks: Published<[Stock]>.Publisher {
        $_stocks
    }
    
    var networkError: Published<NetworkError?>.Publisher {
        $_networkError
    }
    
    
    
    init() {
        Task { await getStockList() } //initial fetch
        startPolling()
    }
    
    private func startPolling() {
        Timer.publish(every: 5, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                Task {
                    await self.getStockList()
                }
            }
            .store(in: &cancellables)
    }
    
    private func getStockList() async {
        let response: AnyPublisher<StocksServiceResponse, NetworkError> = await client.request(for: .getStocks)
        
        response
            .map { $0.data }
            .mapError { err in
                self._networkError = err
                return err
            }
            .replaceError(with: _stocks)
            .assign(to: \._stocks, on: self)
            .store(in: &cancellables)
    }
    
    func getStockDetail(sid: String) async -> AnyPublisher<Stock?, NetworkError> {
        let response: AnyPublisher<StocksServiceResponse, NetworkError> = await client.request(for: .getDetails(sid))
            
        return response
            .map { $0.data.first }
            .eraseToAnyPublisher()
            
    }
}
