//
//  VCardView.swift
//  UniLink
//
//  Created by Evan Best on 2024-03-16.
//

import SwiftUI

struct VCard: View {
    @State var showDetails = false
    var studySession: StudySession
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing:6){
                Text(studySession.title)
                    .customFont(.title3)
                    .layoutPriority(1)
                
                Spacer()
                VStack {
                    // Extract day
                    Text(studySession.date.components(separatedBy: " ")[1])
                        .foregroundColor(.white).customFont(.headline)
                    // Extract month
                    Text(studySession.date.components(separatedBy: " ")[0])
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
            Text(studySession.caption)
                .customFont(.subheadline)
                .opacity(0.7)
                .padding(.bottom, 10)
            
            HStack {
                Text("MEMBERS: \(studySession.members.count)")
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
                        colors: [studySession.color],
                        startPoint: .leading,
                        endPoint: .bottomTrailing
                    )
                )
            )
        .shadow(color: studySession.color.opacity(0.3), radius: 8, x: 0, y: 12)
        .shadow(color: studySession.color.opacity(0.3), radius: 2, x: 0, y: 1)
        .onTapGesture {
            self.showDetails = true
        }
        .sheet(isPresented: $showDetails) {
                VCardDetails(showDetails: $showDetails, studySession: studySession)
        }
    }
}

#Preview {
    VCard(studySession: StudySessions[1])
}
