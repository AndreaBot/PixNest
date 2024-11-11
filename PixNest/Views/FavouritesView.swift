//
//  FavouritesView.swift
//  PixNest
//
//  Created by Andrea Bottino on 30/10/24.
//

import SwiftUI

struct FavouritesView: View {
    
    @EnvironmentObject var coreDataManager: CoreDataManager
    
    @State private var imageDownloader = ImageDownloader()
    @State private var alertsManager = AlertsManager()
    @State private var imagesLoader = ImagesLoader()
    
    @State private var images: [UIImage] = []
    @State private var gridSize: GridSize = .standard
    
    
    var body: some View {
        NavigationStack {
            GeometryReader { proxy in
                switch imagesLoader.loadingState {
                    
                case .noResults:
                    ContentUnavailableView("No saved photos",
                                           systemImage: K.Icons.noFavourites,
                                           description: Text("Get busy exploring our app!"))
                    
                case .loading:
                    Spacer()
                    LoadingView()
                    Spacer()
                    
                case .loaded:
                    ImagesGrid(images: $images,
                               gridSize: $gridSize,
                               screen: proxy.size,
                               isShowingFavs: true) { _ in
                        return
                    } deleteAction: { int in
                        withAnimation {
                            coreDataManager.deleteData(index: int)
                            images.remove(at: int)
                            if images.isEmpty {
                                imagesLoader.loadingState = .noResults
                            }
                        }
                    } downloadAction: { int in
                        guard let highResLink = coreDataManager.savedPhotos[int].highResUrl else {
                            return
                        }
                        if let imageData = await imagesLoader.loadImage(urlString: highResLink ) {
                            imageDownloader.download(image: UIImage(data: imageData)!)
                        }
                    }
                }
            }
            .navigationTitle("My favourites")
        }
        .onAppear {
            imageDownloader.alertsManager = alertsManager
        }
        .task {
            if coreDataManager.savedPhotos.isEmpty {
                imagesLoader.loadingState = .noResults
            } else {
                images = await imagesLoader.loadCoreDataImages(from: coreDataManager.savedPhotos)
            }
        }
        .alert(alertsManager.alertTitle, isPresented: $alertsManager.isShowingAlert) {
            Button("OK") {}
        } message: {
            Text(alertsManager.alertMessage)
        }
    }
}

#Preview {
    FavouritesView()
}
