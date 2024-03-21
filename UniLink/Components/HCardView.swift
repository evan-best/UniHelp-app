//
//  HCardView.swift
//  UniLink
//
//  Created by Evan Best on 2024-03-16.
//

import SwiftUI

struct HCard: View {
    @EnvironmentObject var studySessionViewModel: StudySessionViewModel
    private var session: StudySession {
        return studySessionViewModel.studySession
    }
    var body: some View {
        
        HStack (spacing: 20) {
            VStack (alignment: .leading, spacing: 8){
                Text(session.title)
                    .customFont(.title2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(session.caption)
                    .customFont(.body)
            }
            
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
        .padding(30)
        .frame(maxWidth: .infinity, maxHeight: 110)
        .background(Color(.gray))
        .foregroundStyle(Color(.white))
        .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
    }
}

#Preview {
    HCard()
}
