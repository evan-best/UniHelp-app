//
//  VCardDetailsView.swift
//  UniLink
//
//  Created by Evan Best on 2024-03-18.
//

import SwiftUI
import MapKit

struct VCardDetails: View {
    @Binding var showDetails: Bool
    @EnvironmentObject var viewModel: AuthViewModel
    @EnvironmentObject var studySessionViewModel: StudySessionViewModel
    @Binding var session: StudySession?
    var body: some View {
        Button {
            withAnimation {
                self.showDetails = false
            }
        } label: {
            Circle()
                .fill(Color(.systemGray))
                .frame(width: 40, height: 40)
                .overlay(
                    Image(systemName: "arrow.down")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.white)
                        .frame(width: 20, height: 20)
                        .padding(5)
                )
        }
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(session!.title)
                    .customFont(.title2)
                    .foregroundStyle(Color(.darkGray))
                    .layoutPriority(1)
                
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
            }
            
            Text(session!.caption)
                .customFont(.subheadline)
                .opacity(0.7)
                .padding(.bottom, 10)
            HStack {
                // TODO: Display initials of attendees (max: 3)
                Image(systemName: "person.fill")
                    .foregroundStyle(Color.purple)
                Text("\(session!.members.count)")
                    .customFont(.footnote2)
            }
            .padding(.vertical, 14)
            HStack {
                Image(systemName: "clock")
                    .opacity(0.8)
                Text(session!.time)
                    .customFont(.subheadline)
                    .opacity(0.8)
            }
            Spacer()
            
            HStack (spacing: 160){
                Button {
                    
                } label: {
                    Image(systemName: "heart")
                        .resizable()
                        .frame(width: 25, height: 23, alignment: .leading)
                        .padding(.leading, 15)
                }
                Button {
                    // Check if user is already a member of this studySession
                    if !session!.members.contains(viewModel.currentUser?.fullname) {
                        session!.members.append(viewModel.currentUser?.fullname)
                        studySessionViewModel.saveSession(session: session!)
                        print(session!.members)
                    } else {
                        print("The member \(viewModel.currentUser?.fullname ?? "") is already a member of this study session.")
                    }
                } label: {
                    HStack {
                        Text("SIGN UP")
                            .customFont(.headline)
                    }
                    .foregroundStyle(Color(.white))
                    .frame(width: 140, height: 48)
                }
                .background(Color.mint)
                .cornerRadius(30)
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .fill(Color.white)
                .strokeBorder(Color.black, lineWidth: 1)
                .shadow(color: .black.opacity(0.3), radius: 6, x: 0, y: 4)
        )
        .frame(height: 580)
        .padding([.top, .horizontal], 10)
    }
}


#Preview {
    VCardDetails(showDetails: .constant(true), session: .constant(StudySession(id: UUID(), title: "Title", caption: "caption", date: "Mar 21", time: "12:00pm - 2:00pm ", members: ["Jimmy John"])))
        .environmentObject(StudySessionViewModel())
}
