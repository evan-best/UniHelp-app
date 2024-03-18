//
//  StudySession.swift
//  UniLink
//
//  Created by Evan Best on 2024-03-16.
//

import Foundation
import SwiftUI

struct StudySession: Identifiable {
    var id = UUID()
    var title: String
    var caption: String
    var color: Color
    var date: String
    var time: String
    var members : [String?]
}

var StudySessions = [
    StudySession(title: "COMP1001 Studying", caption: "Study group for COMP1001 - Winter 2023", color: Color(.background2), date: "Mar 16",time: "12:00pm - 2:00pm", members: []),
    StudySession(title: "COMP1002 Studying", caption: "Study group for COMP1002 - Summer 2023", color: Color(.background2), date: "Mar 16",time: "1:00pm - 2:30pm", members: []),
    StudySession(title: "COMP3300 Studying", caption: "Study group for COMP3300 - Winter 2023", color: Color(.background2), date: "Mar 16",time: "6:00pm - 9:00pm", members: []),
    StudySession(title: "COMP2003 Studying", caption: "Study group for COMP2003 - Winter 2023", color: Color(.background2), date: "Mar 16",time: "10:00am - 1:00pm", members: []),
]
