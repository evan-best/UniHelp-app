//
//  TabView.swift
//  UniLink
//
//  Created by Evan Best on 2024-03-16.
//

import SwiftUI
import RiveRuntime

struct TabView: View {
    @AppStorage("selectedTab") var selectedTab: Tab = .home
    @Environment (\.colorScheme) var colorScheme
    var body: some View {
        VStack {
            Spacer()
            HStack {
                tabContent
            }
            .padding(12)
            .background(Color(.systemPurple).opacity(0.9))
            .background(.ultraThinMaterial)
            .mask(RoundedRectangle(cornerRadius: 24, style: .continuous))
            .shadow(color: Color(.systemGray).opacity(0.3),
                    radius: 20, x:0, y: 20 )
            .overlay(RoundedRectangle(cornerRadius: 24, style:.continuous)
                .stroke(.linearGradient(colors: [.white.opacity(0.5), .white.opacity(0)], startPoint: .topLeading, endPoint: .bottomTrailing)))
            .padding(.horizontal, 24)
            
        }
    }
    
    // Tab menu contents
    var tabContent: some View {
        ForEach(tabItems) { item in
            Button {
                try? item.icon.setInput("active", value: true)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    try? item.icon.setInput("active",value:false)
                }
                withAnimation{
                    selectedTab = item.tab
                }
            } label: {
                item.icon.view()
                    .frame(height: 36)
                    .opacity(selectedTab == item.tab ? 1 : 0.5)
                    .background(
                        VStack {
                            RoundedRectangle(cornerRadius: 2)
                                .fill(.white)
                                .frame(width: selectedTab == item.tab ? 20 : 0, height: 4)
                                .offset(y: -20)
                                .opacity(selectedTab == item.tab ? 1 : 0)
                        })
            }
        }
    }
}


struct TabItem: Identifiable {
    var id = UUID()
    var icon: RiveViewModel
    var tab: Tab
}

// Rive items
var tabItems = [
    TabItem(icon: RiveViewModel(fileName: "icons", stateMachineName: "CHAT_Interactivity", artboardName: "CHAT"),tab: .chat),
    TabItem(icon: RiveViewModel(fileName: "icons", stateMachineName: "SEARCH_Interactivity", artboardName: "SEARCH"),tab: .search),
    TabItem(icon: RiveViewModel(fileName: "icons", stateMachineName: "HOME_interactivity", artboardName: "HOME"),tab: .home),
    TabItem(icon: RiveViewModel(fileName: "icons", stateMachineName: "BELL_Interactivity", artboardName: "BELL"),tab: .bell),
    TabItem(icon: RiveViewModel(fileName: "icons", stateMachineName: "USER_Interactivity", artboardName: "USER"),tab: .user),
]

enum Tab: String {
    case chat
    case search
    case home
    case bell
    case user
}
#Preview {
    TabView()
}
