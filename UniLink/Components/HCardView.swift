//
//  HCardView.swift
//  UniLink
//
//  Created by Evan Best on 2024-03-16.
//

import SwiftUI

struct HCard: View {
    @State var session: StudySession
    
    var body: some View {
        
        HStack (spacing: 20) {
            VStack (alignment: .leading, spacing: 8){
                Text(session.title)
                    .customFont(.title2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(session.caption)
                    .customFont(.body)
            }
            Divider()
            
            Text(session.date)
            
        }
        .padding(30)
        .frame(maxWidth: .infinity, maxHeight: 110)
        .background(Color.accentColor)
        .foregroundStyle(Color(.white))
        .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
    }
}

#Preview {
    HCard(session: StudySession(title: "Title", caption: "caption", date: "Mar 20", time: "12:00pm - 2:00pm", members: ["John Doe"]))
}
