//
//  ContentView.swift
//  UniHelp
//
//  Created by Evan Best on 2024-03-09.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @AppStorage("selectedTab") var selectedTab: Tab = .home
    
    var body: some View {
        Group {
            if viewModel.userSession != nil {
                ZStack {
                    switch selectedTab {
                    case .chat:
                        Text("Chat")
                    case .search:
                        Text("Search")
                    case .home:
                        HomeView()
                    case .bell:
                        Text("Notifications")
                    case .user:
                        ProfileView()
                    }
                    TabView()
                }
                    
            } else {
                LoginView()
            }
        }
    }
}

#Preview {
    ContentView()
}
