//
//  FullscreenView.swift
//  PixNest
//
//  Created by Andrea Bottino on 27/10/2024.
//

import SwiftUI

struct FullscreenView: View {
    
    @Environment(\.openURL) var openURL
    @Binding var searchViewModel: SearchViewModel
    
    let imageResult: Result
    
    @State private var imageDownloader = ImageDownloader()
    @State private var photo = UIImage()
    @State private var photographerProfilePicture = UIImage()
    
    
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
                .padding(.horizontal)
            }
        }
        .task {
            await loadImages()
        }
        .toolbar {
            if searchViewModel.hasLoadedImages {
                ToolbarItem(placement: .primaryAction) {
                    Button("Download") {
                        imageDownloader.download(image: photo)
                    }
                }
            }
        }
        .onChange(of: imageDownloader.downloadIsSuccessful) { oldValue, newValue in
            if newValue == true {
                imageDownloader.triggerDownloadCount(imageResult.links.download_location)
            }
        }
        .alert(imageDownloader.downloadAlertTitle, isPresented: $imageDownloader.showingDownloadAlert) {
            Button("OK") {}
        } message: {
            Text(imageDownloader.downloadAlertMessage)
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
