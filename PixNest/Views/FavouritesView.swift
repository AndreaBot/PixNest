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
    
    @State private var imageDownloader = ImageDownloader()
    @State private var images: [UIImage] = []
    
    
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
                        ImagesGrid(searchViewModel: $searchViewModel, images: $images, screen: proxy.size, isShowingFavs: true) { _ in
                            return
                        } deleteAction: { int in
                            coreDataManager.deleteData(index: int)
                        } downloadAction: { int in
                            guard let highResLink = coreDataManager.savedPhotos[int].highResUrl else {
                                return
                            }
                            if let imageData = await searchViewModel.loadImage(urlString: highResLink ) {
                                imageDownloader.download(image: UIImage(data: imageData)!)
                            }
                        }
                    }
                }
            }
            .navigationTitle("My favourites")
        }
        .task {
            await loadImages()
        }
        .onChange(of: coreDataManager.savedPhotos) { _, _ in
            Task {
                await loadImages()
            }
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
                images.append(UIImage!)
            }
        }
        searchViewModel.hasLoadedImages = true
    }
}

#Preview {
    FavouritesView(searchViewModel: .constant(SearchViewModel()))
}
