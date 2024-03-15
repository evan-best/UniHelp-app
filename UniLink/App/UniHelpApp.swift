//
//  UniHelpApp.swift
//  UniHelp
//
//  Created by Evan Best.
//

import SwiftUI
import FirebaseCore


@main
struct UniHelpApp: App {
    @StateObject var viewModel = AuthViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
