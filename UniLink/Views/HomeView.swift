//
//  HomeView.swift
//  UniLink
//
//  Created by Evan Best on 2024-03-16.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("selectedTab") var selectedTab: Tab = .home
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        ZStack {
            Color(.background)
                .ignoresSafeArea()
                .opacity(0.5)
            ScrollView {
                content
            }
        }
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: 0){
            Text("Open Groups")
                .customFont(.largeTitle)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(StudySessions) { session in
                        VCard(studySession: session)
                    }
                }
                .padding(20)
                .padding(.bottom, 10)
            }
            
            Text("My Groups")
                .customFont(.title3)
                .padding(.horizontal,20)
                .padding(.bottom, 10)
                .frame(maxWidth: .infinity, alignment: .center)
            
            VStack (spacing: 20) {
                ForEach(StudySessions) { session in
                    HCard(studySession: session)
                }
            }
            .padding(20)
        }
    }
}



#Preview {
    HomeView()
}
