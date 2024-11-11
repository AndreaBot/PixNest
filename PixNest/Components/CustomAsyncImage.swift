//
//  CustomAsyncImage.swift
//  PixNest
//
//  Created by Andrea Bottino on 9/11/24.
//

import SwiftUI

struct CustomAsyncImage: View {
    
    @Binding var loadingState: LoadingState
    let urlString: String
    let shape: AnyShape
    let scaleFactor: Double

    
    var body: some View {
        AsyncImage(url: URL(string: urlString)) { phase in
            switch phase {
            case .empty:
                LoadingView()
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
                    .clipShape(shape)
                    .containerRelativeFrame(.horizontal) { size, axis in
                        size * scaleFactor
                    }
                    .onAppear {
                        loadingState = .loaded
                    }
            case .failure(_):
                Image(systemName: K.Icons.loadingError)
                    .font(.largeTitle)
            @unknown default:
                Image(systemName: K.Icons.loadingError)
                    .font(.largeTitle)
            }
        }
    }
}


//#Preview {
//    CustomAsyncImage()
//}
