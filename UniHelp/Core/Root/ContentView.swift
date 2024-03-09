//
//  ContentView.swift
//  UniHelp
//
//  Created by Evan Best on 2024-03-09.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    
    var body: some View {
        Group {
            if $viewModel.userSession != nil {
                ProfileView()
            } else {
                LoginView()
            }
        }
    }
}

#Preview {
    ContentView()
}
