//
//  FullscreenView.swift
//  PixNest
//
//  Created by Andrea Bottino on 27/10/2024.
//

import SwiftUI

struct FullscreenView: View {
    
    @Environment(\.openURL) var openURL
    @EnvironmentObject var coreDataManager: CoreDataManager
    
    @Binding var searchViewModel: SearchViewModel
    
    let imageResult: Result
    var imageAlreadyInFavourites: Bool {
        return coreDataManager.savedPhotos.contains(where: { savedPhoto in
            savedPhoto.highResUrl == imageResult.urls.full
        })
    }
    
    @State private var imageDownloader = ImageDownloader()
    @State private var photo = UIImage()
    @State private var photographerProfilePicture = UIImage()
    
    @State private var alertsManager = AlertsManager()
    
    
    var body: some View {
        Group {
            if !searchViewModel.hasLoadedImages {
                LoadingView()
            } else {
                VStack {
                    Spacer()
                    
                    Image(uiImage: photo)
                        .resizable()
                        .scaledToFit()
                    
                    Spacer()
                    
                    PhotoCreditsBar(photographerProfilePicture: photographerProfilePicture, photographernName: imageResult.user.name, photographerPageURL: imageResult.user.links.html, openURLAction: openURL)
                }
                .padding()
            }
        }
        .onAppear {
            imageDownloader.alertsManager = alertsManager
            coreDataManager.alertsManager = self.alertsManager
        }
        .task {
            await loadImages()
        }
        .toolbar {
            if searchViewModel.hasLoadedImages {
                ToolbarItem(placement: .primaryAction) {
                    HStack {
                        Button("Download") {
                            imageDownloader.download(image: photo)
                        }
                        Button(imageAlreadyInFavourites ? "Saved" : "Add to my favourites") {
                            coreDataManager.createNewEntity(lowResLink: imageResult.urls.small, highResLink: imageResult.urls.full)
                        }
                        .disabled(imageAlreadyInFavourites)
                       
                    }
                }
            }
        }
        .onChange(of: imageDownloader.downloadIsSuccessful) { oldValue, newValue in
            if newValue == true {
                imageDownloader.triggerDownloadCount(imageResult.links.download_location)
                imageDownloader.downloadIsSuccessful = false
            }
        }
        .alert(alertsManager.alertTitle, isPresented: $alertsManager.isShowingAlert) {
            Button("OK") {
                if alertsManager.triggerType == .coreDataManager {
                    withAnimation {
                        coreDataManager.loadData()
                    }
                }
            }
        } message: {
            Text(alertsManager.alertMessage)
        }
    }
    
    func loadImages() async {
        searchViewModel.hasLoadedImages = false
        async let profileImageData = searchViewModel.loadImage(urlString: imageResult.user.profile_image.medium)
        async let mainImageData = searchViewModel.loadImage(urlString: imageResult.urls.full)
        
        if let profileData = await profileImageData, let profileImage = UIImage(data: profileData) {
            photographerProfilePicture = profileImage
        }
        
        if let mainData = await mainImageData, let mainImage = UIImage(data: mainData) {
            photo = mainImage
        }
        searchViewModel.hasLoadedImages = true
    }
}


//#Preview {
//    FullscreenView()
//}
