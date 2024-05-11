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
        VStack(alignment: .leading, spacing: 6) {
            HStack{
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
            HStack {
                Text(session!.caption)
                    .customFont(.subheadline)
                    .opacity(0.8)
                    .padding(.bottom, 8)
                .lineLimit(2)
            }
            HStack {
                Image(systemName: "clock")
                    .opacity(0.8)
                Text(session!.time)
                    .customFont(.subheadline)
                    .opacity(0.8)
            }
            HStack {
                Image(systemName: "person.fill")
                    .foregroundStyle(Color(.systemPurple))
                Text("\(session!.members.count)")
                    .customFont(.footnote2)
                
                // TODO: Display initials of attendees (max: 3)
            }
            .padding(.top, 2)
            images.randomElement()?
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 140, alignment: .center)
        }
        .padding(12)
        .foregroundStyle(Color(.darkGray))
        .frame(width: 240, height: 350, alignment: .topLeading)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(.white)
                .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: 3)
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
    VCard(session: StudySession(id: UUID(),title: "COMP2003 Studying", caption: "A test study group for CS2003. This is a super long caption that will test the formatting", date: "Mar 21", time: "12:00pm - 2:00pm ", members: ["Jimmy John"]))
        .environmentObject(StudySessionViewModel())
}
