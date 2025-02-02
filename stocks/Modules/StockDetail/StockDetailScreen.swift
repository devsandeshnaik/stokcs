//
//  StockDetailScreen.swift
//  stocks
//
//  Created by Sandesh Naik on 02/02/25.
//

import SwiftUI
import Charts

struct StockDetailScreen: View {
    var stock: Stock
    @StateObject var viewModel: StockDetailVM
    
    var body: some View {
        VStack {
            chartView
            List {
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
        .navigationTitle(stock.sid)
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
    
    StockDetailScreen(stock: stock, viewModel: StockDetailVM(stock: stock, stockService: StocksService()))
}
