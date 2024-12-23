//
//  ImagesGrid.swift
//  PixNest
//
//  Created by Andrea Bottino on 26/10/2024.
//

import SwiftUI

struct ImagesGrid: View {
    
    @Binding var images: [UIImage]
    @Binding var gridSize: GridSize
    
    var chosenGrid: [GridItem] {
        switch gridSize {
        case .standard:
            [GridItem(.adaptive(minimum: screen.width/3))]
        case .compact:
            [GridItem(.adaptive(minimum: screen.width/4))]
        case .dense:
            [GridItem(.adaptive(minimum: screen.width/5))]
        }
    }
    
    var radBasedOnGridType: CGFloat {
        switch gridSize {
        case .standard:
            10
        case .compact:
            6
        case .dense:
            3
        }
    }
    
    let screen: CGSize
    let isShowingFavs: Bool
    
    let tapAction: (Int) -> Void
    let deleteAction: (Int) -> Void
    let downloadAction: (Int) async -> Void
    
    @State private var showingOverlay = false
    @State private var selectedIndex: Int?
    
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: chosenGrid) {
                ForEach(images.indices, id: \.self) { index in
                    Image(uiImage:images[index])
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: radBasedOnGridType))
                        .overlay {
                            if showingOverlay {
                                if let selectedIndex = selectedIndex {
                                    if selectedIndex == index {
                                        FavouritePhotoOverlay(deleteAction: {
                                            deleteAction(selectedIndex)
                                            self.selectedIndex = nil
                                        }, downloadAction: {
                                            await downloadAction(selectedIndex)
                                        })
                                        .padding()
                                        .transition(.scale.combined(with: .opacity))
                                    }
                                }
                            }
                        }
                        .onTapGesture {
                            if isShowingFavs {
                                withAnimation(.smooth) {
                                    selectedIndex = index
                                    showingOverlay = true
                                }
                            } else {
                                tapAction(index)
                            }
                        }
                }
            }
            .padding(.horizontal)
        }
    }
}


#Preview {
    ImagesGrid(images: .constant([UIImage]()), gridSize: .constant(.standard), screen: CGSize(width: 600, height: 300), isShowingFavs: false, tapAction:  {_ in
        print("navigate to fullscreen")
    }, deleteAction: {_ in }, downloadAction: {_ in })
}
