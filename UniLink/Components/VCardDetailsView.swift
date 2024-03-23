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
    private var session: StudySession {
        return studySessionViewModel.studySession
    }
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
                // TODO: Display initials of attendees (max: 3)
                Image(systemName: "person.fill")
                Text("\(session.members.count)")
                    .customFont(.footnote2)
            }
            
            Spacer()
            
            HStack (spacing: 160){
                Button {
                    
                } label: {
                    Image(systemName: "heart")
                        .resizable()
                        .frame(width: 25, height: 25, alignment: .leading)
                        .padding(.leading, 10)
                }
                Button {
                    // Check if user is already a member of this studySession
                    if !studySessionViewModel.studySession.members.contains(viewModel.currentUser?.fullname) {
                        studySessionViewModel.studySession.members.append(viewModel.currentUser?.fullname)
                        studySessionViewModel.saveSession()
                    } else {
                        print("The member \(viewModel.currentUser?.fullname ?? "") is already a member of this study session.")
                    }
                } label: {
                    HStack {
                        Text("SIGN UP")
                            .customFont(.headline)
                    }
                    .foregroundStyle(Color.white)
                    .frame(width: 140, height: 48)
                }
                .background(Color.mint)
                .cornerRadius(30)
            }
        }
        .padding(16)
        .foregroundStyle(Color(.white))
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [.accentColor],
                        startPoint: .leading,
                        endPoint: .bottomTrailing
                    )
                )
                .shadow(color: .accentColor.opacity(0.3), radius: 8, x: 0, y: 12)
                .shadow(color: .accentColor.opacity(0.3), radius: 2, x: 0, y: 1)
        )
        .frame(height: 580)
        .padding([.top, .horizontal], 10)
    }
}


#Preview {
    VCardDetails(showDetails: .constant(true))
        .environmentObject(StudySessionViewModel())
}
