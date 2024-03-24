//
//  StudySession.swift
//  UniLink
//
//  Created by Evan Best on 2024-03-16.
//

import Foundation
import SwiftUI

struct StudySession: Identifiable, Codable {
    var id: UUID
    var title: String
    var caption: String
    var date: String
    var time: String
    var members: [String?]
    // TODO: var image: Image. Need to figure out how to store this somehow?
    init(id: UUID, title: String, caption: String, date: String, time: String, members: [String?]) {
        self.id = id
        self.title = title
        self.caption = caption
        self.date = date
        self.time = time
        self.members = members
    }
}
