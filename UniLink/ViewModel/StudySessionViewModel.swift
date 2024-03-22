//
//  StudySessionViewModel.swift
//  UniLink
//
//  Created by Evan Best on 2024-03-19.
//

import Foundation
import FirebaseDatabase
import FirebaseDatabaseSwift

@MainActor
class StudySessionViewModel: ObservableObject {
    @Published var studySession: StudySession
    private let ref = Database.database().reference().child("study_sessions")
    
    init() {
        self.studySession = StudySession(title: "Title", caption: "caption", date: "Mar 21", time: "12:00pm - 2:00pm ", members: ["Jimmy John"])
    }
    
    func createSession(session: StudySession) async throws {
        try await self.ref.child(session.id.uuidString).setValue(["title": session.title, "caption": session.caption, "date": session.date, "time": session.time, "members": session.members])
    }
    
    func fetchSession(session: StudySession) async {
        guard let result = try? await self.ref.child(session.id.uuidString).getData() else { return }
        self.studySession = try! result.data(as: StudySession.self)
    }
    
    func fetchAllSessions() async {
        guard let result = try? await [self.ref.getData()] else { return }
    }
}
