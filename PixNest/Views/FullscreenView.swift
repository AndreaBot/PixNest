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
    
    @State private var imageDownloader = ImageDownloader()
    @State private var imagesLoader = ImagesLoader()
    @State private var alertsManager = AlertsManager()
    
    let imageResult: Result
    var imageAlreadyInFavourites: Bool {
        return coreDataManager.savedPhotos.contains(where: { savedPhoto in
            savedPhoto.highResUrl == imageResult.urls.full
        })
    }
    
    
    var body: some View {
        VStack {
            Spacer()
            
            CustomAsyncImage(loadingState: $imagesLoader.loadingState,
                             urlString: imageResult.urls.full,
                             shape: AnyShape(RoundedRectangle(cornerRadius: 20)),
                             scaleFactor: 0.9)
            
            Spacer()
            
            PhotoCreditsBar(photographerPhotoLink: imageResult.user.profileImage.medium,
                            photographerName: imageResult.user.name,
                            photographerPageURL: imageResult.user.links.html,
                            openURLAction: openURL)
            .padding()
        }
        .onAppear {
            imageDownloader.alertsManager = alertsManager
            coreDataManager.alertsManager = alertsManager
        }
        .toolbar {
            if imagesLoader.loadingState == .loaded {
                ToolbarItem(placement: .primaryAction) {
                    HStack {
                        Button("Download") {
                            Task {
                                guard let photoData = await imagesLoader.loadImage(urlString: imageResult.urls.full) else {
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
