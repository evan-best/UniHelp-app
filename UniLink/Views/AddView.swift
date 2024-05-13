//
//  AddView.swift
//  UniLink
//
//  Created by Evan Best on 2024-04-25.
//

import SwiftUI
import MapKit

struct AddView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @EnvironmentObject var studySessionViewModel: StudySessionViewModel
    @State private var locationService = LocationService(completer: .init())
    @State var title: String = ""
    @State var description: String = ""
    @State var date = Date()
    @State var time = Date()
    @State var location: String = ""
    @State private var search: String = ""
    var isAllFieldsFilled: Bool {
        !title.isEmpty && !description.isEmpty && !location.isEmpty
    }
    
    var body: some View {
        Form {
            VStack(alignment: .leading, spacing: 24) {
                
                Section {
                    Text("New Study Session")             .customFont(.title2)
                    TextField("Title", text: $title, axis: .vertical)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                Section {
                    TextField("Description", text: $description, axis: .vertical)
                        .customFont(.subheadline)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .lineLimit(3, reservesSpace: true)
                }
                
                Section {
                    HStack (alignment: .center, spacing: 28) {
                        HStack {
                            Image(systemName: "calendar.badge.plus")
                            DatePicker("", selection: $date, displayedComponents: .date)
                        }
                        
                        HStack {
                            Image(systemName: "clock")
                            DatePicker("", selection: $time, displayedComponents: .hourAndMinute)
                        }
                    }
                }
                
                Section {
                    HStack {
                        Image(systemName: "location")
                        TextField("Search for a location", text: $search)
                            .bold()
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .autocorrectionDisabled()
                    }
                    
                    List {
                        ForEach(locationService.completions) { completion in
                            Button(action: { updateLocation(title: completion.title, subtitle: completion.subTitle) }) {
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(completion.title)
                                        .font(.headline)
                                        .fontDesign(.rounded)
                                    Text(completion.subTitle)
                                }
                            }
                            .listRowBackground(Color.clear)
                        }
                    }
                    
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                }
                
                .onChange(of: search) {
                    locationService.update(queryFragment: search)
                }
                
                Spacer()
                
                HStack {
                    Spacer()
                    Button(action: {
                        createNewSession()
                        title = ""
                        description = ""
                        date = Date()
                        time = Date()
                        location = ""
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .foregroundStyle(Color.purple)
                            .frame(width: 60, height: 60)
                            .padding(10)
                    }
                }
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
    func createNewSession() {
        Task {
            if isAllFieldsFilled {
                let formatter1 = DateFormatter()
                formatter1.dateStyle = .short
                let formatter2 = DateFormatter()
                formatter2.timeStyle = .short
                let session = StudySession(id: UUID(), title: title, caption: description, date: formatter1.string(from: date), time: formatter2.string(from: time), members: ["you"], creator: "you", location: location)
                do {
                    studySessionViewModel.saveSession(session: session)
                }
            } else {
                print("DEBUG: Please fill all required fields before creating a session.")
            }
        }
    }
    func updateLocation(title: String, subtitle: String) {
        self.location = title + " " + subtitle
        self.search = title
        print(self.location)
        print(self.search)
    }
}

#Preview {
    AddView()
}
