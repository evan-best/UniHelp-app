//
//  VCardView.swift
//  UniLink
//
//  Created by Evan Best on 2024-03-16.
//

import SwiftUI

struct VCard: View {
    @State var showDetails = false
    @EnvironmentObject var studySessionViewModel: StudySessionViewModel
    @State var session: StudySession
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing:6){
                Text(session.title)
                    .customFont(.title2)
                    .layoutPriority(1)
                
                Spacer()
                VStack {
                    // Extract day
                    Text(session.date.components(separatedBy: " ")[1])
                        .foregroundColor(.white).customFont(.headline)
                    // Extract month
                    Text(session.date.components(separatedBy: " ")[0])
                        .foregroundColor(.white)
                        .customFont(.headline)
                }
                .padding(.horizontal,10)
                .padding(.vertical, 6)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(.systemGray2))
                )
            }
            Text(session.caption)
                .customFont(.subheadline)
                .opacity(0.7)
                .padding(.bottom, 10)
            
            HStack {
                Image(systemName: "person.fill")
                Text("\(session.members.count)")
                    .customFont(.footnote2)
                
                // TODO: Display initials of attendees (max: 3)
            }
        }
        .padding(20)
        .foregroundStyle(Color(.white))
        .frame(width: 240, height: 360, alignment: .topLeading)
        .background(
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [.accentColor],
                        startPoint: .leading,
                        endPoint: .bottomTrailing
                    )
                )
            )
        .shadow(color: .accentColor.opacity(0.3), radius: 8, x: 0, y: 12)
        .shadow(color: .accentColor.opacity(0.3), radius: 2, x: 0, y: 1)
        .onTapGesture {
            self.showDetails = true
        }
        .sheet(isPresented: $showDetails) {
            VCardDetails(showDetails: $showDetails, session: $session)
        }
    }
}

#Preview {
    VCard(session: StudySession(title: "Title", caption: "caption", date: "Mar 21", time: "12:00pm - 2:00pm ", members: ["Jimmy John"]))
        .environmentObject(StudySessionViewModel())
}
