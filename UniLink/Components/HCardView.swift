//
//  HCardView.swift
//  UniLink
//
//  Created by Evan Best on 2024-03-16.
//

import SwiftUI

struct HCard: View {
    @State var showDetails = false
    @EnvironmentObject var studySessionViewModel: StudySessionViewModel
    @State var session: StudySession?
    var body: some View {
        
        HStack {
            VStack (alignment: .leading, spacing: 6){
                Text(session!.title)
                    .customFont(.title2)
                    .foregroundStyle(Color(.darkGray))
                Text(session!.caption)
                    .customFont(.body)
                    .foregroundStyle(Color(.darkGray))
                HStack {
                    // TODO: Display initials of attendees (max: 3)
                    Image(systemName: "person.fill")
                        .resizable()
                        .frame(width: 12, height: 12)
                        .foregroundStyle(Color(.systemPurple))
                    Text("\(session!.members.count)")
                        .customFont(.footnote2)
                        .foregroundStyle(Color(.darkGray))
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack {
                // Extract day
                Text(session!.date.components(separatedBy: " ")[1])
                    .foregroundColor(.white).customFont(.headline)
                // Extract month
                Text(session!.date.components(separatedBy: " ")[0])
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
        .padding(20)
        .frame(width: 320, height: 90, alignment: .center)
        .padding(10)
        .foregroundStyle(Color(.white))
        .background(
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [.white],
                        startPoint: .leading,
                        endPoint: .bottomTrailing
                    )
                )
            )
        .shadow(color: .black.opacity(0.3), radius: 8, x: 0, y: 2)

        
        .onTapGesture {
            self.showDetails = true
        }
        .sheet(isPresented: $showDetails) {
            VCardDetails(showDetails: $showDetails, session: $session)
        }
    }
}

#Preview {
    HCard(session: StudySession(id: UUID(), title: "Title", caption: "caption", date: "Mar 21", time: "12:00pm - 2:00pm ", members: ["Jimmy John"]))
        .environmentObject(StudySessionViewModel())
}
