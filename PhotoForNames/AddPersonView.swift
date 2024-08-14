//
//  AddPersonView.swift
//  PhotoForNames
//
//  Created by Kenji Dela Cruz on 8/13/24.
//

import SwiftUI
import SwiftData
import PhotosUI

struct AddPersonView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var viewModel = ViewModel()
    var body: some View {
        VStack{
            PhotosPicker(selection: $viewModel.selectedItem){
                if let processedImage = viewModel.processedImage {
                    processedImage
                        .resizable()
                        .scaledToFit()
                }else {
                    ContentUnavailableView("No picture", systemImage: "photo.badge.plus", description: Text("Tap to import a photo"))
                }
            }
            .buttonStyle(.plain)
            .onChange(of: viewModel.selectedItem){
                viewModel.loadImage()
            }.alert("Enter this person's name", isPresented: $viewModel.showEditName) {
                TextField("Enter name", text: $viewModel.name)
                Button("Ok") {
                    viewModel.saveImage(modelContext: modelContext)
                    dismiss()
                }
            }
        }
        .onAppear(perform: {
            viewModel.locationFetcher.start()
        })
    }
}

#Preview {
    AddPersonView()
}
