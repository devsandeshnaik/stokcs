//
//  HomeView.swift
//  stocks
//
//  Created by Sandesh Naik on 01/02/25.
//

import SwiftUI

struct HomeScreen: View {
    @Environment(\.modelContext) var modelContext
    private let stoksService = StocksService()
    var viewModel: HomeScreenVM
    
    var body: some View {
        NavigationStack {
            TabView {
                Tab("Stocks", systemImage: "chart.line.uptrend.xyaxis") {
                    StocklistScreen(viewModel: StocklistScreenVM(stocksService: stoksService))
                }
                
                Tab("Wishlist", systemImage: "heart") {
                    WishlistScreen(viewModel: WishlistScreenVM(stocksService: stoksService))
                }
            }
            .navigationTitle(Text("Stocks"))
            .navigationBarTitleDisplayMode(.large)
        }
        .tint(.primary)
        .environmentObject(StockDataStore(modelContext: modelContext))
        
    }
}

#Preview {
    HomeScreen(viewModel: HomeScreenVM())
}
