//
//  StockCellView.swift
//  stocks
//
//  Created by Sandesh Naik on 01/02/25.
//

import SwiftUI
import SwiftData

struct StockCellView: View {
    @EnvironmentObject var stocksDataStore: StockDataStore
    let stock: Stock
    
    /// This property returns Bool denoting whether the stock is in user's wishlist or not
    private var isWishlisted: Bool {
        let _stock = stocksDataStore.stocks.first { $0.sid == stock.sid }
        return _stock != nil
    }
    
    var body: some View {
        HStack(spacing: 16) {
            addToWishlistButton
            Divider()
            stockBasicInfoView
            Spacer()
            stockPriceInfoView
        }
        .tint(.primary)
        .padding()
        .frame(height: 80)
        .background {
            RoundedRectangle(cornerRadius: 8)
                .fill(.background.opacity(0.95))
                .shadow(color: .gray, radius: 1,x: 1, y: 1)
        }
    }
    
    /// This returns the  add to wishlist button view
    private var addToWishlistButton: some View {
        Button {
            isWishlisted ? removeFromWishlist() : saveToWishlist()
        } label: {
            Image(systemName: isWishlisted ? "heart.fill" : "heart")
                .resizable()
                .fontWeight(.thin)
                .frame(width: 32, height: 30)
                .foregroundStyle(.red)
        }
    }
    
    /// This returns the  sid and price change info view
    private var stockBasicInfoView: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(stock.sid)
            
            Text(stock.change, format: .number)
                .font(.callout)
                .fontWeight(.medium)
                .foregroundStyle(.white)
                .padding(.horizontal)
                .frame(height: 24)
                .background {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(stock.change > 0 ? Color.green : Color.red)
                }
        }
        .frame(height: 50)
    }
    
    /// This returns the price and volume info view
    private var stockPriceInfoView: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(stock.price, format: .currency(code: "INR"))
                .fontWeight(.medium)
            
            HStack {
                Text("Volume:")
                Text(stock.volume, format: .number)
                Spacer()
            }
            .lineLimit(1)
            .font(.callout)
            .foregroundStyle(Color.gray)
            .minimumScaleFactor(0.7)
            .frame(height: 24)
        }
        .frame(maxWidth: 150)
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
    
    Group {
        StockCellView(stock: stock)
            .modelContainer(modelContainer)
        
        StockCellView(stock: stock)
            .modelContainer(for: Stock.self, inMemory: true)
    }
    .padding()
}
