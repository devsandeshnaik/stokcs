//
//  HomeScreen.swift
//  stocks
//
//  Created by Sandesh Naik on 01/02/25.
//

import SwiftUI

struct StocklistScreen: View {
    @StateObject var viewModel: StocklistScreenVM
    
    var body: some View {
        ScrollView {
            ForEach(viewModel.stocks, id: \.sid) { stock in
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
    StocklistScreen(viewModel: StocklistScreenVM(stocksService: StocksService()))
}
