//
//  FavouritesView.swift
//  PixNest
//
//  Created by Andrea Bottino on 30/10/24.
//

import SwiftUI

struct FavouritesView: View {
    
    @Environment(\.coreDataManager) var coreDataManager
    @Binding var searchViewModel: SearchViewModel
    
    @State private var images: [Image] = []
    
    var body: some View {
        NavigationStack {
            GeometryReader { proxy in
                if coreDataManager.savedPhotos.isEmpty {
                    ContentUnavailableView("No saved photos",
                                           systemImage: K.Icons.noFavourites,
                                           description: Text("Get busy exploring our app!"))
                } else {
                    if !searchViewModel.hasLoadedImages {
                        LoadingView()
                    } else {
                        ImagesGrid(searchViewModel: $searchViewModel, screen: proxy.size, images: $images, isShowingFavs: true) { _ in
                            print("tapped!")
                        }
                    }
                }
            }
            .navigationTitle("My favourites")
        }
        .task {
            await loadImages()
        }
    }
    
    func loadImages() async {
        searchViewModel.hasLoadedImages = false
        images = []
        for photo in coreDataManager.savedPhotos {
            guard let photoUrl = photo.lowResUrl else {
                return
            }
            if let imageData = await searchViewModel.loadImage(urlString: photoUrl) {
                let UIImage = UIImage(data: imageData)
                images.append(Image(uiImage: UIImage!))
            }
        }
        searchViewModel.hasLoadedImages = true
    }
}

#Preview {
    FavouritesView(searchViewModel: .constant(SearchViewModel()))
}
