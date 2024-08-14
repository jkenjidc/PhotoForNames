//
//  ContentView.swift
//  PhotoForNames
//
//  Created by Kenji Dela Cruz on 8/13/24.
//

import SwiftUI
import SwiftData
import PhotosUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Person.name) var persons: [Person]
    @State private var showEditSheet = false
    var body: some View {
        NavigationStack{
            VStack {
                List {
                    ForEach(persons) { person in
                        NavigationLink {
                            PersonDetailView(person: person)
                        } label: {
                            HStack {
                                if person.uiImage != UIImage() {
                                    Image(uiImage: person.uiImage)
                                        .resizable()
                                        .frame(width: 65, height: 65)
                                        .scaledToFit()
                                } else {
                                    Image(systemName: "person")
                                        .resizable()
                                        .frame(width: 65, height: 65)
                                        .scaledToFit()
                                }
                                Text(person.name)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Remember")
            .toolbar {
                Button("Add a person", systemImage: "plus") {
                    showEditSheet = true
                }
            }
            .sheet(isPresented: $showEditSheet, content: {
                AddPersonView()
            })
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Person.self, configurations: config)
    
    for i in 1..<10 {
        let user = Person(name: "Test \(i)", latitude: 53, longitude: -3, photo: nil)
        container.mainContext.insert(user)
    }
    
    return ContentView()
        .modelContainer(container)
}
