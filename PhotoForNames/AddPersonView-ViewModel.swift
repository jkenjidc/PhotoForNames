//
//  ContentView-ViewModel.swift
//  PhotoForNames
//
//  Created by Kenji Dela Cruz on 8/13/24.
//

import Foundation
import SwiftData
import PhotosUI
import CoreImage
import SwiftUI

@MainActor
extension AddPersonView {
    @Observable
    class ViewModel {
        var selectedItem: PhotosPickerItem?
        var processedImage: Image?
        var name = ""
        var showEditName =  false
        var rawImage = Data()
        let locationFetcher = LocationFetcher()
        var latitude: Double?
        var longitude: Double?
        func loadImage() {
            Task {
                guard let imageData = try  await self.selectedItem?.loadTransferable(type: Data.self) else { return }
                guard let inputImage = UIImage(data: imageData) else { return }
                
                self.processedImage = Image(uiImage: inputImage)
                self.rawImage = imageData
            }
            self.showEditName = true
        }
        
        func saveImage(modelContext: ModelContext) {
            if let location = self.locationFetcher.lastKnownLocation {
                self.latitude = location.latitude
                self.longitude = location.longitude
            } else {
                print("Your location is unknown")
            }
            modelContext.insert(Person(name: self.name, latitude: latitude, longitude: longitude, photo: self.rawImage))
        }
        
    }
}
