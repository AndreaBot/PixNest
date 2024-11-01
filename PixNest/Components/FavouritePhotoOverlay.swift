//
//  FavouritePhotoOverlay.swift
//  PixNest
//
//  Created by Andrea Bottino on 31/10/24.
//

import SwiftUI

struct FavouritePhotoOverlay: View {
    
    let deleteAction: () -> Void
    let downloadAction: () async -> Void
    
    var body: some View {
        VStack {
            Button {
                deleteAction()
            } label: {
                Image(systemName: K.Icons.noFavourites)
            }
            
            Spacer()
            
            Button {
                Task {
                    await downloadAction()
                }
            } label: {
                Image(systemName: K.Icons.download)
            }
        }
        .buttonStyle(.plain)
        .font(.largeTitle)
        .padding()
        .background(.background.opacity(0.7))
        .clipShape(Capsule())
        
    }
}

#Preview {
    FavouritePhotoOverlay(deleteAction: {}, downloadAction: {})
}
