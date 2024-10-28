//
//  PhotoCreditsBar.swift
//  PixNest
//
//  Created by Andrea Bottino on 27/10/2024.
//

import SwiftUI

struct PhotoCreditsBar: View {
    
    let photographerProfilePicture: UIImage
    let photographernName: String
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
                        Image(uiImage: photographerProfilePicture)
                            .font(.title)
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading) {
                            Text(photographernName)
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
