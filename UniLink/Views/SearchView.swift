//
//  SearchView.swift
//  UniLink
//
//  Created by Evan Best on 2024-04-07.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var studySessionViewModel: StudySessionViewModel
    @State private var sessions: [StudySession] = []
    @State private var searchTerm: String = ""
    @State var showDetails = false
    @State var selectedSession: StudySession? = nil
    var filteredSessions: [StudySession] {
        guard !searchTerm.isEmpty else { return sessions }
        return sessions.filter {$0.title.localizedCaseInsensitiveContains(searchTerm)}
    }
    
    // DateFormatter to parse and format the date
    // TODO: Make this operation in a new file
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    var body: some View {
        
        NavigationView {
            VStack {
                List (filteredSessions) { session in
                    Button {
                    } label: {
                        HStack {
                            VStack (alignment: .leading, spacing: 5){
                                Text(session.title)
                                    .customFont(.headline)
                                Text(session.time)
                                    .customFont(.footnote)
                                HStack {
                                    Image(systemName: "person.fill")
                                        .foregroundStyle(Color(.systemPurple))
                                    Text("\(session.members.count)")
                                        .customFont(.footnote2)
                                    
                                    // TODO: Display initials of attendees (max: 3)
                                }
                            }
                            Spacer()
                            VStack {
                                // Parse and format the date
                                let date = session.date
                                let parsedDate = dateFormatter.date(from: date)!
                                let month = Calendar.current.component(.month, from: parsedDate)
                                let day = Calendar.current.component(.day, from: parsedDate)
                                
                                Text(getMonthAbbreviation(month))
                                    .foregroundColor(.white)
                                    .customFont(.headline)
                                Text("\(day)")
                                    .foregroundColor(.white)
                                    .customFont(.headline)
                            }
                            .padding(.horizontal, 8)
                            .padding(.vertical,3)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color(.systemGray2))
                            )
                        }
                    }
                    .foregroundStyle(Color(.darkGray))
                    .onTapGesture {
                        self.selectedSession = session
                        self.showDetails = true
                    }
                    .sheet(isPresented: $showDetails) {
                        VCardDetails(showDetails: $showDetails, session: $selectedSession)
                    }
                }
            }
        }
        .ignoresSafeArea(.all)
        .listStyle(InsetGroupedListStyle())
        .searchable(text: $searchTerm, prompt: "Search")
        .task { fetchSessions() }
    }
    
    
    func fetchSessions() {
        Task {
            do {
                if let sessionList = try await studySessionViewModel.fetchAllSessions() {
                    sessions = sessionList
                }
            } catch {
                print("DEBUG: Error fetching sessions: \(error.localizedDescription)")
            }
        }
    }
    
    func getMonthAbbreviation(_ month: Int) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM"
        return dateFormatter.shortMonthSymbols[month - 1]
    }
}



#Preview {
    SearchView()
        .environmentObject(StudySessionViewModel())
}
