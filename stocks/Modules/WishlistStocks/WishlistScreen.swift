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
                StockCellView(stock: stock)
            }
            .padding()
        }
    }
}

#Preview {
    WishlistScreen(viewModel: WishlistScreenVM(stocksService: StocksService()))
}
