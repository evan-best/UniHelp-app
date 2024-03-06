//
//  ContentView.swift
//  UniHelp
//
//  Created by Evan Best on 2024-03-09.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        var count = 0;
        
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue,.white]), 
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            Button {
                count += 1
                print(count)
            }
        label: {
            Text("Button")
                    .padding(10)
            }
            .buttonStyle(.borderedProminent)
            
        }
    }
}

#Preview {
    ContentView()
}
