//
//  HCardView.swift
//  UniLink
//
//  Created by Evan Best on 2024-03-16.
//

import SwiftUI

struct HCard: View {
    var studySession: StudySession
    
    var body: some View {
        
        HStack (spacing: 20) {
            VStack (alignment: .leading, spacing: 8){
                Text(studySession.title)
                    .customFont(.title2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(studySession.caption)
                    .customFont(.body)
            }
            Divider()
            
            Text(studySession.date)
            
        }
        .padding(30)
        .frame(maxWidth: .infinity, maxHeight: 110)
        .background(studySession.color)
        .foregroundStyle(Color(.white))
        .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
    }
}

#Preview {
    HCard(studySession: StudySessions[3])
}
