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
        self.studySession = StudySession(id: UUID(), title: "Title", caption: "caption", date: "Mar 21", time: "12:00pm - 2:00pm ", members: ["Jimmy John"])
    }
    
    func createSession() async throws {
        let session = self.studySession
        do {
            try await self.ref.child(session.id.uuidString).setValue(["title": session.title, "caption": session.caption, "date": session.date, "time": session.time, "members": session.members])
        } catch {
            print("DEBUG: Session could not be created.")
        }
    }
    
    func saveSession(session: StudySession) {
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

    
    func fetchSession(sessionID: UUID) async throws -> StudySession? {
        let snapshot = try await ref.child(sessionID.uuidString).getData() // Fetch data for the specific session
        guard let sessionData = snapshot.value as? [String: Any] else {
            print("DEBUG: Failed to fetch session with ID \(sessionID)")
            return nil
        }
        
        // Parse session data
        guard let title = sessionData["title"] as? String,
              let caption = sessionData["caption"] as? String,
              let date = sessionData["date"] as? String,
              let time = sessionData["time"] as? String,
              let members = sessionData["members"] as? [String] else {
            print("DEBUG: Invalid session data for session with ID \(sessionID)")
            return nil
        }
        
        // Create and return the session object
        return StudySession(id: sessionID, title: title, caption: caption, date: date, time: time, members: members)
    }


    
    func fetchAllSessions() async throws -> [StudySession]? {
        let snapshot = try await ref.getData()
        guard let sessionData = snapshot.value as? [String: Any] else {
            print("DEBUG: Failed to fetch sessions")
            return nil
        }
        var sessions: [StudySession] = []
        for (key, value) in sessionData {
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
        return sessions
    }
    
    func getMembers(session: StudySession) async throws -> [String?]? {
        // Fetch the session
        guard let fetchedSession = try await fetchSession(sessionID: session.id) else {
            // Session not found
            return nil
        }
        
        // Return the members of the fetched session
        return fetchedSession.members
    }

}
