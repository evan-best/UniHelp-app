//
//  HomeView.swift
//  UniLink
//
//  Created by Evan Best on 2024-03-16.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("selectedTab") var selectedTab: Tab = .home
    
    var body: some View {
        ZStack {
            switch selectedTab {
            case .chat:
                Text("Chat")
            case .search:
                Text("Search")
            case .home:
                Text("Home")
            case .bell:
                Text("Search")
            case .user:
                ProfileView()
            }
            
            TabView()
        }
    }
}

#Preview {
    HomeView()
}
