//
//  CustomAsyncImage.swift
//  PixNest
//
//  Created by Andrea Bottino on 9/11/24.
//

import SwiftUI

struct CustomAsyncImage: View {
    
    @Binding var loadingBool: Bool
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
                        loadingBool = true
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
