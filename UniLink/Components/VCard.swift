//
//  VCard.swift
//  UniLink
//
//  Created by Evan Best on 2024-03-16.
//

import SwiftUI

struct VCard: View {
    var studySession: StudySession
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(studySession.date)
                .customFont(.subheadline)
                .frame(maxWidth: .infinity, alignment: .topTrailing)
            
            Text(studySession.title)
                .customFont(.title2)
                .frame(maxWidth: 170, alignment: .topLeading)
                .layoutPriority(1)
            
            Text(studySession.caption)
                .customFont(.subheadline)
                .opacity(0.7)
                .padding(.bottom, 10)
            
            Text("MEMBERS: \(studySession.members.count)")
                .customFont(.footnote2)
            
            HStack {
                // TODO: Display initials of attendees (max: 3)
            }
        }
        .padding(30)
        .foregroundStyle(Color(.white))
        .frame(width: 260, height: 270)
        .background(.linearGradient(colors: [studySession.color], startPoint: .leading, endPoint: .bottomTrailing))
        .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .shadow(color: studySession.color.opacity(0.3), radius: 8, x: 0, y: 12)
        .shadow(color: studySession.color.opacity(0.3), radius: 2, x: 0, y: 1)
    }
}

#Preview {
    VCard(studySession: StudySessions[1])
}
