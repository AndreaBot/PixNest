//
//  FavouritePhotoOverlay.swift
//  PixNest
//
//  Created by Andrea Bottino on 31/10/24.
//

import SwiftUI

struct FavouritePhotoOverlay: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            Button {
                print("Unsaved!")
            } label: {
                Image(systemName: K.Icons.noFavourites)
            }
            
            Spacer()
            
            Button {
                print("Downloaded!")
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
    FavouritePhotoOverlay()
}
