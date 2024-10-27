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
    
    var body: some View {
        HStack {
            Image(uiImage: photographerProfilePicture)
                .font(.title)
                .clipShape(Circle())
            
            HStack(alignment: .bottom) {
                Text(photographernName)
                    .underline()
                    .font(.title3)
                Spacer()
                Text("Unsplash.com")
                    .font(.subheadline)
            }
        }
    }
}

//#Preview {
//    PhotoCreditsBar()
//}
