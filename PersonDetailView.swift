//
//  PersonDetailView.swift
//  PhotoForNames
//
//  Created by Kenji Dela Cruz on 8/13/24.
//

import SwiftUI
import CoreLocation
import MapKit
import SwiftData

struct PersonDetailView: View {
    var person: Person
    var initialPosition: MapCameraPosition {
        return MapCameraPosition.region(MKCoordinateRegion(
            center: person.coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)))
    }
    var body: some View {
        NavigationStack{
            VStack {
                if person.uiImage != UIImage() {
                    Image(uiImage: person.uiImage)
                        .resizable()
                        .scaledToFit()
                } else {
                    Image(systemName: "person")
                        .resizable()
                        .scaledToFit()
                        .padding()
                }
                
                Map(initialPosition: initialPosition)
                {
                    Annotation(person.name, coordinate: person.coordinate){
                        Image(systemName: "mappin")
                            .resizable()
                            .frame(width: 15, height: 35)
                            .foregroundStyle(.red)
                    }
                }
                .mapStyle(.hybrid)
                .padding(25)
            }
            .navigationTitle(person.name)
        }
        
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Person.self, configurations: config)
    let user = Person(name: "Test", latitude: 53, longitude: -3, photo: nil)
    return PersonDetailView(person: user)
        .modelContainer(container)
}
