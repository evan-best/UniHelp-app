//
//  LoadingView.swift
//  UniLink
//
//  Created by Evan Best on 2024-05-06.
//

import SwiftUI

struct LoadingView: View {
    
    var body: some View {
        VStack {
            ZStack {
                Color(.systemBackground)
                    .ignoresSafeArea()
                
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(2)
            }
        }
    }
}

#Preview {
    LoadingView()
}
