//
//  TabView.swift
//  UniLink
//
//  Created by Evan Best on 2024-03-16.
//

import SwiftUI


enum Tab: String, CaseIterable {
    case chat
    case search
    case home
    case add
    case user
    
    var symbolName: String {
        switch self {
        case .chat:
            return "message"
        case .search:
            return "magnifyingglass.circle"
        case .home:
            return "house"
        case .add:
            return "plus.circle"
        case .user:
            return "person"
        }
    }
}


struct TabView: View {
    @AppStorage("selectedTab") var selectedTab: Tab = .home
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                ForEach(Tab.allCases, id: \.rawValue) { tab in
                    Spacer()
                    Image(systemName: selectedTab == tab ? tab.symbolName + ".fill" : tab.symbolName)
                        .scaleEffect(selectedTab == tab ? 1.25 : 1)
                        .foregroundStyle(Color.white)
                        .font(.system(size:22))
                        .onTapGesture {
                            withAnimation(.easeIn(duration: 0.1)) {
                                selectedTab = tab
                            }
                        }
                    Spacer()
                }
            }
            .frame(width: nil, height: 60)
            .background(Color(.systemPurple).opacity(0.9))
            .background(.thinMaterial)
            .cornerRadius(20)
            .padding()
        }
    }
}
    
#Preview {
    TabView()
}
