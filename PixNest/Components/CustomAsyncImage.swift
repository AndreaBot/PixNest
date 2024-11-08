//
//  CustomAsyncImage.swift
//  PixNest
//
//  Created by Andrea Bottino on 8/11/24.
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
                Image(systemName: "exclamationmark.icloud")
            @unknown default:
                Image(systemName: "exclamationmark.icloud")
            }
        }
    }
}

//#Preview {
//    CustomAsyncImage()
//}
