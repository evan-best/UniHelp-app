//
//  AddView.swift
//  UniLink
//
//  Created by Evan Best on 2024-04-25.
//

import SwiftUI

struct AddView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @EnvironmentObject var studySessionViewModel: StudySessionViewModel
    @State var title: String = ""
    @State var date = Date()
    @State var description: String = ""
    @State var time = Date()
    
    var body: some View {
        Form {
            VStack(alignment: .leading, spacing: 24) {
                
                Section {
                    Text("New Study Session")             .customFont(.title2)
                    TextField("Title", text: $title, axis: .vertical)
                        .customFont(.title3)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                Section {
                    TextField("Description", text: $description, axis: .vertical)
                        .customFont(.subheadline)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .lineLimit(5, reservesSpace: true)
                }
                Section {
                    HStack (alignment: .center, spacing: 28) {
                        HStack {
                            Image(systemName: "calendar.badge.plus")
                                .opacity(0.8)
                            DatePicker("", selection: $date, displayedComponents: .date)
                        }
                        
                        HStack {
                            Image(systemName: "clock")
                                .opacity(0.8)
                            DatePicker("", selection: $time, displayedComponents: .hourAndMinute)
                        }
                    }
                }
                HStack {
                    Image(systemName: "location")
                }
                
                Spacer()
            }
            .padding(16)
            .listRowBackground(Color(.clear))
            .background(
                RoundedRectangle(cornerRadius: 30, style: .continuous)
                    .fill(Color.white)
                    .strokeBorder(Color.black, lineWidth: 1)
                    .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 2)
            )
            .frame(width: 345, height: 600)
        }
        .background(Color.clear)
    }
}

#Preview {
    AddView()
}
