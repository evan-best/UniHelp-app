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
    let session = StudySession(title: "Title", caption: "caption", date: "Mar 20", time: "12:00pm - 2:00pm", members: ["John Doe"])
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
                .customFont(.title2)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    VCard(session: session)
                }
                .padding(20)
                .padding(.bottom, 10)
                
            }
            .padding(20)
            
            Text("Your Groups")
                .customFont(.title2)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.horizontal, 20)
            ScrollView(.vertical, showsIndicators: false) {
                if session.members.contains(viewModel.currentUser?.fullname){
                    HCard(session: session)
                }
            }
        }
    }
}



#Preview {
    HomeView()
}
