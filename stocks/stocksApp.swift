//
//  stocksApp.swift
//  stocks
//
//  Created by Sandesh Naik on 01/02/25.
//

import SwiftUI
import SwiftData

@main
struct stocksApp: App {
    
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.systemBackground
        
        let navigationBar = UINavigationBar.appearance()
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        navigationBar.compactAppearance = appearance
        
    }
    var body: some Scene {
        WindowGroup {
            HomeScreen(viewModel: HomeScreenVM())
                .modelContainer(for: Stock.self)
        }
    }
}
