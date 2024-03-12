//
//  User.swift
//  UniHelp
//
//  Created by Evan Best on 2024-03-09.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    let fullname: String
    let email: String
    
    var initials: String {
        let formatter = PersonNameComponentsFormatter()
        if let componenents = formatter.personNameComponents(from: fullname) {
            formatter.style = .abbreviated
            return formatter.string(from: componenents)
        }
        
        return ""
    }
}
