//
//  PageNavigator.swift
//  PixNest
//
//  Created by Andrea Bottino on 26/10/2024.
//

import SwiftUI

struct PageNavigator: View {
    
    @Binding var currentPage: Int
    @Binding var totalPages: Int
    
    var body: some View {
        HStack {
            Button {
                currentPage -= 1
            } label: {
                Image(systemName: K.Icons.prevPage)
            }
            .disabled(currentPage == 1)
            
            Spacer()
            
            Text("Page \(currentPage) / \(totalPages)")
                .font(.title3)
            
            Spacer()
            
            Button {
                currentPage += 1
            } label: {
                Image(systemName: K.Icons.nextPage)
            }
            .disabled(currentPage == totalPages)
        }
        .font(.title)
    }
}


#Preview {
    PageNavigator(currentPage: .constant(2), totalPages: .constant(100))
}
