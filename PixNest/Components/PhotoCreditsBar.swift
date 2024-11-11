//
//  PhotoCreditsBar.swift
//  PixNest
//
//  Created by Andrea Bottino on 27/10/2024.
//

import SwiftUI

struct PhotoCreditsBar: View {
    
    let photographerPhotoLink: String
    let photographerName: String
    let photographerPageURL: String
    let openURLAction: OpenURLAction
    
    
    var body: some View {
        HStack {
            Button {
                if let url = URL(string: photographerPageURL) {
                    openURLAction(url)
                }
            } label: {
                HStack {
                    HStack {
                        CustomAsyncImage(loadingState: .constant(.noResults), urlString: photographerPhotoLink, shape: AnyShape(Circle()), scaleFactor: 0.15)
                        
                        VStack(alignment: .leading) {
                            Text(photographerName)
                                .underline()
                                .font(.title3)
                            
                            Text("Unsplash.com")
                                .font(.caption)
                        }
                    }
                }
                Spacer()
            }
        }
    }
}

//#Preview {
//    PhotoCreditsBar()
//}
