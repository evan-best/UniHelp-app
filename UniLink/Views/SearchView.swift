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
                                // Extract day
                                Text(session.date.components(separatedBy: " ")[1])
                                    .foregroundColor(.white).customFont(.headline)
                                // Extract month
                                Text(session.date.components(separatedBy: " ")[0])
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
}



#Preview {
    SearchView()
        .environmentObject(StudySessionViewModel())
}
