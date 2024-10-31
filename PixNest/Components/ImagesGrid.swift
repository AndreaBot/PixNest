//
//  ImagesGrid.swift
//  PixNest
//
//  Created by Andrea Bottino on 26/10/2024.
//

import SwiftUI

struct ImagesGrid: View {
    
    @Binding var searchViewModel: SearchViewModel
    let screen: CGSize
    @Binding var images: [Image]
    let isShowingFavs: Bool
    let tapAction: (Int?) -> Void
    
    @State private var showingOverlay = false
    @State private var selectedIndex: Int?
    
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: screen.width/3))]) {
                ForEach(images.indices, id: \.self) { index in
                    Button {
                        if isShowingFavs {
                            selectedIndex = index
                            
                            showingOverlay = true
                            
                            
                        } else {
                            tapAction(index)
                        }
                    } label: {
                        images[index]
                            .resizable()
                            .scaledToFit()
                            .overlay {
                                if showingOverlay {
                                    if selectedIndex == index {
                                        FavouritePhotoOverlay()
                                            .padding()
                                    }
                                }
                            }
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}


#Preview {
    ImagesGrid(searchViewModel: .constant(SearchViewModel()), screen: CGSize(width: 600, height: 300), images: .constant([Image]()), isShowingFavs: false) {_ in
        print("navigate to fullscreen")
    }
}
