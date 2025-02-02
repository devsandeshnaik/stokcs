//
//  WishlistScreen.swift
//  stocks
//
//  Created by Sandesh Naik on 02/02/25.
//

import SwiftUI

struct WishlistScreen: View {
    
    @EnvironmentObject var stocksDataStore: StockDataStore
    @StateObject var viewModel: WishlistScreenVM
    
    var wishListStocks: [Stock] {
        viewModel.stocks.filter { stock in
            stocksDataStore.stocks.contains(where: { $0.sid == stock.sid })
        }
    }
    
    var body: some View {
        ScrollView {
            ForEach(stocksDataStore.stocks, id: \.sid) { stock in
                NavigationLink(destination: stockDetailView(stock: stock)) {
                    StockCellView(stock: stock)
                }
            }
            .padding()
        }
    }
    
    func stockDetailView(stock: Stock) -> some View {
        StockDetailScreen(stock: stock,
                          viewModel: StockDetailVM(stock: stock,
                                                   stockService: viewModel.stocksService))
    }
}

#Preview {
    WishlistScreen(viewModel: WishlistScreenVM(stocksService: StocksService()))
}
