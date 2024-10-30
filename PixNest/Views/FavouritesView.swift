//
//  FavouritesView.swift
//  PixNest
//
//  Created by Andrea Bottino on 30/10/24.
//

import SwiftUI

struct FavouritesView: View {
    
    @Environment(\.coreDataManager) var coreDataManager
    @Environment(\.dismiss) var dismiss
    
    @Binding var searchViewModel: SearchViewModel
    
    @State private var images: [Image] = []
    
    var body: some View {
        Group {
            if !searchViewModel.hasLoadedImages {
                LoadingView()
            } else {
                NavigationStack {
                    GeometryReader { proxy in
                        ImagesGrid(searchViewModel: $searchViewModel, screen: proxy.size, images: $images) { _ in
                            print("tapped!")
                        }
                    }
                    .navigationTitle("My favourites")
                    .toolbar {
                        ToolbarItem(placement: .navigation) {
                            Button {
                                dismiss()
                            } label: {
                                Image(systemName: K.Icons.goBack)
                            }
                        }
                    }
                }
            }
        }
        .task {
            await loadImages()
        }
    }
    
    func loadImages() async {
        coreDataManager.loadData()
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

//#Preview {
//    FavouritesView()
//}
