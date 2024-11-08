//
//  FavouritesView.swift
//  PixNest
//
//  Created by Andrea Bottino on 30/10/24.
//

import SwiftUI

struct FavouritesView: View {
    
    @EnvironmentObject var coreDataManager: CoreDataManager
    
    @Binding var searchViewModel: SearchViewModel
    
    @State private var imageDownloader = ImageDownloader()
    @State private var alertsManager = AlertsManager()
    @State private var coreDataAdapter = CoreDataAdapter()
    
    @State private var images: [URLS] = []
    @State private var gridSize: GridSize = .standard
    
    
    var body: some View {
        NavigationStack {
            GeometryReader { proxy in
                if coreDataManager.savedPhotos.isEmpty {
                    ContentUnavailableView("No saved photos",
                                           systemImage: K.Icons.noFavourites,
                                           description: Text("Get busy exploring our app!"))
                } else {
                    ImagesGrid(searchViewModel: $searchViewModel,
                               results: $coreDataAdapter.convertedData,
                               gridSize: $gridSize,
                               screen: proxy.size,
                               isShowingFavs: true) { _ in
                        return
                    } deleteAction: { int in
                        coreDataManager.deleteData(index: int)
                        coreDataAdapter.convertedData.remove(at: int)
                        
                    } downloadAction: { int in
                        guard let highResLink = coreDataManager.savedPhotos[int].highResLink else {
                            return
                        }
                        if let imageData = await searchViewModel.loadImage(urlString: highResLink ) {
                            imageDownloader.download(image: UIImage(data: imageData)!)
                        }
                    }
                }
            }
            .navigationTitle("My favourites")
        }
        .onAppear {
            coreDataAdapter.convertData(from: coreDataManager.savedPhotos)
            imageDownloader.alertsManager = alertsManager
        }
        .alert(alertsManager.alertTitle, isPresented: $alertsManager.isShowingAlert) {
            Button("OK") {}
        } message: {
            Text(alertsManager.alertMessage)
        }
    }
}

#Preview {
    FavouritesView(searchViewModel: .constant(SearchViewModel()))
}




