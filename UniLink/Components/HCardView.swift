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
    
    // DateFormatter to parse and format the date
    // TODO: Make this operation in a new file
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
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
                // Parse and format the date
                if let date = session?.date {
                    let parsedDate = dateFormatter.date(from: date)!
                    let month = Calendar.current.component(.month, from: parsedDate)
                    let day = Calendar.current.component(.day, from: parsedDate)
                    
                    Text("\(day)")
                        .foregroundColor(.white)
                        .customFont(.headline)
                    
                    Text(getMonthAbbreviation(month))
                        .foregroundColor(.white)
                        .customFont(.headline)
                }
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
    func getMonthAbbreviation(_ month: Int) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM"
        return dateFormatter.shortMonthSymbols[month - 1]
    }
}

#Preview {
    HCard(session: StudySession(id: UUID(), title: "Title", caption: "caption", date: "2024-05-25", time: "12:00pm - 2:00pm", members: ["Jimmy John"], creator: "Jimmy John", location: "Memorial University of Newfoundland, St. John's, NL A1C 5S7"))
        .environmentObject(StudySessionViewModel())
}
