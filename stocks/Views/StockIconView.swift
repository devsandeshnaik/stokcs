//
//  StockIconView.swift
//  stocks
//
//  Created by Sandesh Naik on 01/02/25.
//

import SwiftUI

struct StockIconView: View {
    let stockSID: String
    var body: some View {
        Text(stockSID)
            .font(.system(size: 20, weight: .bold))
            .minimumScaleFactor(0.75)
            .lineLimit(1)
            .foregroundColor(.primary.opacity(0.2))
            .rotationEffect(.degrees(-45))
            .frame(width: 50, height: 50)
            .background(Color.gray.opacity(0.2)) // Grey background
            .clipShape(RoundedRectangle(cornerRadius: 4))
            .shadow(radius: 5) // Optional shadow for better contrast
    }
}

#Preview {
    StockIconView(stockSID: "HDBK")
}
