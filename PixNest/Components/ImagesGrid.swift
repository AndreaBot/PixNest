//
//  ImagesGrid.swift
//  PixNest
//
//  Created by Andrea Bottino on 26/10/2024.
//

import SwiftUI

struct ImagesGrid: View {
    
    @Binding var searchViewModel: SearchViewModel
    let screen: CGSize
    @Binding var images: [Image]
    let tapAction: (Int?) -> Void
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: screen.width/3))]) {
                ForEach(images.indices, id: \.self) { index in
                    Button {
                        tapAction(index)
                    } label: {
                        images[index]
                            .resizable()
                            .scaledToFit()
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}


#Preview {
    ImagesGrid(searchViewModel: .constant(SearchViewModel()), screen: CGSize(width: 600, height: 300), images: .constant([Image]())) {_ in 
        print("navigate to fullscreen")
    }
}
