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
    @State var session: StudySession?
    @State var images = [Image("VCard1"), Image("VCard2"), Image("VCard3"), Image("VCard4"), Image("VCard5"), Image("VCard7")]
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing:6){
                Text(session!.title)
                    .customFont(.title2)
                    .foregroundStyle(Color(.darkGray))
                
                Spacer()
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
                .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 1)
            }
            Text(session!.time)
                .customFont(.subheadline)
                .opacity(0.7)
                .padding(.bottom, 10)
            
            HStack {
                Image(systemName: "person.fill")
                    .foregroundStyle(Color(.systemPurple))
                Text("\(session!.members.count)")
                    .customFont(.footnote2)
                
                // TODO: Display initials of attendees (max: 3)
            }
            Spacer()
            images.randomElement()?
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 160, alignment: .center)
        }
        .padding(20)
        .foregroundStyle(Color(.darkGray))
        .frame(width: 240, height: 360, alignment: .topLeading)
        .background(
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [.white],
                        startPoint: .leading,
                        endPoint: .bottomTrailing
                    )
                )
                .shadow(color: .black.opacity(0.3), radius: 8, x: 0, y: 12)
                .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 1)
        )
        .onTapGesture {
            self.showDetails = true
        }
        .sheet(isPresented: $showDetails) {
            VCardDetails(showDetails: $showDetails, session: $session)
        }
    }
}

#Preview {
    VCard(session: StudySession(id: UUID(),title: "COMP2003 Studying", caption: "caption", date: "Mar 21", time: "12:00pm - 2:00pm ", members: ["Jimmy John"]))
        .environmentObject(StudySessionViewModel())
}
