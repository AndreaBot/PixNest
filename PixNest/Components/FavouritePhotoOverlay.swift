//
//  FavouritePhotoOverlay.swift
//  PixNest
//
//  Created by Andrea Bottino on 31/10/24.
//

import SwiftUI

struct FavouritePhotoOverlay: View {
    
    @Binding var selectedIndex: Int
    let deleteAction: (Int) -> Void
    let downloadAction: (Int) async -> Void
    
    var body: some View {
        VStack {
            Button {
                deleteAction(selectedIndex)
            } label: {
                Image(systemName: K.Icons.noFavourites)
            }
            
            Spacer()
            
            Button {
                Task {
                   await downloadAction(selectedIndex)
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
    FavouritePhotoOverlay(selectedIndex: .constant(0), deleteAction: {_ in }, downloadAction: {_ in })
}
