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
    
    func createSession() async throws {
        let session = self.studySession
        do {
            try await self.ref.child(session.id.uuidString).setValue(["title": session.title, "caption": session.caption, "date": session.date, "time": session.time, "members": session.members])
        } catch {
            print("DEBUG: Session could not be created.")
        }
    }
    
    func saveSession() {
        let session = self.studySession
        let key = session.id.uuidString
        let loc_session = [
            "title": session.title,
            "caption": session.caption,
            "date": session.date,
            "time": session.time,
            "members": session.members
        ] as [String : Any]
        let session_update = ["\(key)": loc_session]
        ref.updateChildValues(session_update) { error, _ in
            if let error = error {
                print("DEBUG: Session could not be saved. Error: \(error.localizedDescription)")
            } else {
                print("DEBUG: Session saved successfully.")
            }
        }
    }

    
    func fetchSession(session: StudySession) async {
        guard let result = try? await self.ref.child(session.id.uuidString).getData() else { return }
        self.studySession = try! result.data(as: StudySession.self)
    }
    
    func fetchAllSessions(completion: @escaping ([StudySession]?) -> Void) async {
        ref.observe(.value) { snapshot in
            guard let sessionData = snapshot.value as? [String: Any] else {
                print("DEBUG: Failed to fetch sessions")
                return
            }
            var sessions: [StudySession] = []
            for (key,value) in sessionData {
                if let sessionData = value as? [String: Any],
                   let title = sessionData["title"] as? String,
                   let caption = sessionData["caption"] as? String,
                   let date = sessionData["date"] as? String,
                   let time = sessionData["time"] as? String,
                   let members = sessionData["members"] as? [String] {
                    let id = UUID(uuidString: key)!
                    let session = StudySession(id: id, title: title, caption: caption, date: date, time: time, members: members)
                    sessions.append(session)
                }
            }
            completion(sessions)
        }
    }
    
}
