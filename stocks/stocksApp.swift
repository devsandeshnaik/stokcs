//
//  stocksApp.swift
//  stocks
//
//  Created by Sandesh Naik on 01/02/25.
//

import SwiftUI
import SwiftData

//TODO: - 1 Add fav list
//TODO: - 2 Break big views into small indivial var/func
//TODO: - 3 Add documentation
//TODO: - Setup github with read me


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
