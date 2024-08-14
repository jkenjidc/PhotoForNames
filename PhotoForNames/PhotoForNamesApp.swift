//
//  PhotoForNamesApp.swift
//  PhotoForNames
//
//  Created by Kenji Dela Cruz on 8/13/24.
//

import SwiftUI
import SwiftData

@main
struct PhotoForNamesApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Person.self)
        
    }
}
