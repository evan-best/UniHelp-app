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
                HStack {
                    Text(session!.time)
                        .customFont(.subheadline2)
                        .opacity(0.7)
                        .padding(.bottom, 4)
                }
                .foregroundStyle(Color(.systemGray))
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
        .padding(10)
        .frame(width: 320, height: 90, alignment: .center)
        .padding(4)
        .foregroundStyle(Color(.white))
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color.white)
        )
        .overlay(RoundedRectangle(cornerRadius: 20)
            .stroke(Color.black, lineWidth: 0.5))
        
        .onTapGesture {
            self.showDetails = true
        }
        .sheet(isPresented: $showDetails) {
            VCardDetails(showDetails: $showDetails, session: $session)
        }
    }
}

#Preview {
    HCard(session: StudySession(id: UUID(), title: "Title", caption: "caption", date: "Mar 21", time: "12:00pm - 2:00pm", members: ["Jimmy John"]))
        .environmentObject(StudySessionViewModel())
}
