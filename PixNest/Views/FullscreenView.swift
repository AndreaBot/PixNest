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
            savedPhoto.highResLink == imageResult.urls.full
        })
    }
    
    @State private var imageDownloader = ImageDownloader()
    @State private var alertsManager = AlertsManager()
    
    
    var body: some View {
        VStack {
            Spacer()
            
            CustomAsyncImage(loadingBool: $searchViewModel.hasLoadedFullImage,
                             urlString: imageResult.urls.full,
                             shape: AnyShape(RoundedRectangle(cornerRadius: 20)),
                             scaleFactor: 0.9)
            
            Spacer()
            
            PhotoCreditsBar(loadingBool: $searchViewModel.hasLoadedPhotographerImage,
                            photographerPhotoLink: imageResult.user.profileImage.medium,
                            photographerName: imageResult.user.name,
                            photographerPageURL: imageResult.user.links.html,
                            openURLAction: openURL)
            .padding()
        }
        .onAppear {
            searchViewModel.hasLoadedFullImage = false
            imageDownloader.alertsManager = alertsManager
            coreDataManager.alertsManager = alertsManager
        }
        .toolbar {
            if searchViewModel.hasLoadedFullImage {
                ToolbarItem(placement: .primaryAction) {
                    HStack {
                        Button("Download") {
                            Task {
                                guard let photoData = await searchViewModel.loadImage(urlString: imageResult.urls.full) else {
                                    return
                                }
                                guard let photoToDownload = UIImage(data: photoData) else {
                                    return
                                }
                                imageDownloader.download(image: photoToDownload)
                            }
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
                imageDownloader.triggerDownloadCount(imageResult.links.downloadLocation)
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
}

//#Preview {
//    FullscreenView()
//}
