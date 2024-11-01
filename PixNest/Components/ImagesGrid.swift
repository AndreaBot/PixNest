//
//  ImagesGrid.swift
//  PixNest
//
//  Created by Andrea Bottino on 26/10/2024.
//

import SwiftUI

struct ImagesGrid: View {
    
    @Binding var searchViewModel: SearchViewModel
    @Binding var images: [UIImage]
    
    let screen: CGSize
    let isShowingFavs: Bool
    
    let tapAction: (Int) -> Void
    let deleteAction: (Int) -> Void
    let downloadAction: (Int) async -> Void
    
    @State private var showingOverlay = false
    @State private var selectedIndex = 0
    
    
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
                        Image(uiImage:images[index])
                            .resizable()
                            .scaledToFit()
                            .overlay {
                                if showingOverlay {
                                    if selectedIndex == index {
                                        FavouritePhotoOverlay(selectedIndex: $selectedIndex, deleteAction: { _ in
                                            deleteAction(selectedIndex)
                                        }, downloadAction: { _ in
                                          await downloadAction(selectedIndex)
                                        })
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
    ImagesGrid(searchViewModel: .constant(SearchViewModel()), images: .constant([UIImage]()), screen: CGSize(width: 600, height: 300), isShowingFavs: false, tapAction:  {_ in
        print("navigate to fullscreen")
    }, deleteAction: {_ in }, downloadAction: {_ in })
}
