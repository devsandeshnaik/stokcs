//
//  StockDetailScreen.swift
//  stocks
//
//  Created by Sandesh Naik on 02/02/25.
//

import SwiftUI
import Charts
import SwiftData

struct StockDetailScreen: View {
    @EnvironmentObject var stocksDataStore: StockDataStore
    let stock: Stock
    
    /// This property returns Bool denoting whether the stock is in user's wishlist or not
    private var isWishlisted: Bool {
        let _stock = stocksDataStore.stocks.first { $0.sid == stock.sid }
        return _stock != nil
    }
    
    @StateObject var viewModel: StockDetailVM
    
    var body: some View {
        VStack {
            chartView
            Divider()
            addToWishlistButton
            Divider()
            List {
                Section(header: Text("Details")) {
                    sidInfo
                    priceInfo
                    priceChange
                    highPrice
                    lowPrice
                    stocksVolume
                    lastClose
                    lastUpdated
                }
            }
            .listStyle(.plain)
        }
        .navigationTitle(stock.sid)
        .navigationBarTitleDisplayMode(.large)
        .task {
            viewModel.startPolling()
        }
    }
    
    private var chartView : some View {
        Chart {
            ForEach(0..<viewModel.stockHistory.count, id: \.self) { index in
                LineMark(x: .value("date", index),
                         y: .value("Price", viewModel.stockHistory[index].price))
                .symbol(.circle)
                .interpolationMethod(.catmullRom)
            }
        }
        .frame(height: 300)
        .padding(.horizontal)
    }
    
    private var addToWishlistButton: some View {
        Button {
            withAnimation {
                isWishlisted ? removeFromWishlist() : saveToWishlist()
            }
        } label: {
            Capsule()
                .stroke(Color.primary, lineWidth: 1)
                .frame(height: 44)
                .padding()
                .overlay {
                    HStack {
                        Label(title: {
                            if isWishlisted {
                                Text("REMOVE FROM WISHLIST")
                            } else {
                                Text("ADD TO WISHLIST")
                            }
                        }, icon: {
                            Image(systemName: isWishlisted ? "heart.fill" : "heart")
                                .resizable()
                                .fontWeight(.thin)
                                .frame(width: 24, height: 24)
                                .foregroundStyle(.red)
                        })
                        .font(.callout)
                    }
                }
        }
        
    }
    
    private var sidInfo: some View {
        HStack {
            Text("SID:")
            Spacer()
            Text(stock.sid)
        }
    }
    
    private var priceInfo: some View {
        HStack {
            Text("Price:")
            Spacer()
            Text(stock.price, format: .currency(code: "INR"))
        }
    }
    
    private var priceChange: some View {
        HStack {
            Text("Change:")
            Spacer()
            Text(stock.change, format: .number)
                .foregroundStyle(stock.change > 0 ? .green : .red)
        }
    }
    
    private var highPrice: some View {
        HStack {
            Text("High:")
            Spacer()
            Text(stock.high, format: .number)
        }
    }
    
    private var lowPrice: some View {
        HStack {
            Text("Low:")
            Spacer()
            Text(stock.low, format: .number)
        }
    }
    
    private var stocksVolume: some View {
        HStack {
            Text("Volume:")
            Spacer()
            Text(stock.volume, format: .number)
        }
    }
    
    private var lastClose: some View {
        HStack {
            Text("Last Close:")
            Spacer()
            Text(stock.close, format: .number)
        }
    }
    
    private var lastUpdated: some View {
        HStack {
            Text("Last Updated:")
            Spacer()
            if let lastUpdateDate {
                Text(lastUpdateDate, format: .dateTime)
            } else {
                Text("N/A")
            }
        }
    }
    
    private var lastUpdateDate: Date? {
        (viewModel.stockHistory.last ?? stock).date.toDate()
    }
    
    /// This methods adds the stock to wishlist
    private func saveToWishlist() {
        stocksDataStore.addNewStock(stock)
    }
    
    /// This methods removes the stock to wishlist
    private func removeFromWishlist() {
        guard let _stock = stocksDataStore.stocks.first(where: { $0.sid == stock.sid }) else {
            return
        }
        stocksDataStore.deleteStock(_stock)
    }
}

#Preview {
    let stock = Stock(
        sid: "RELI",
        price: 1264.45,
        close: 1265.1,
        change: -0.65,
        high: 1270.55,
        low: 1262.15,
        volume: 966785,
        date: "2025-02-01T04:46:52.000Z"
    )
    
    var modelContainer: ModelContainer {
        let container = try! ModelContainer(for: Stock.self,
                                            configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        container.mainContext.insert(stock)
        return container
    }
    
    StockDetailScreen(stock: stock, viewModel: StockDetailVM(stock: stock, stockService: StocksService()))
        .modelContainer(modelContainer)
        .environmentObject(StockDataStore(modelContext: modelContainer.mainContext))
}
