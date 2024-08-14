//
//  Person.swift
//  PhotoForNames
//
//  Created by Kenji Dela Cruz on 8/13/24.
//

import Foundation
import SwiftData
import SwiftUI
import CoreLocation


@Model
class Person: Identifiable {
    let id = UUID()
    let name: String
    var latitude: CLLocationDegrees?
    var longitude: CLLocationDegrees?
    @Attribute(.externalStorage) var photo: Data?
    
    var uiImage: UIImage {
        if let imageData = photo {
            if let uiImage = UIImage(data: imageData) {
                return uiImage
            }
        }
        
        return UIImage()
    }
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude ?? 56, longitude: longitude ?? -3)
    }
    
    init(name: String, latitude: CLLocationDegrees? = 56, longitude: CLLocationDegrees? = -3, photo: Data? = nil) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.photo = photo
    }
}
