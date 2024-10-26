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
            Spacer()
            
            Button {
                currentPage -= 1
            } label: {
                Image(systemName: K.Icons.prevPage)
            }
            .disabled(currentPage == 1)
            
            Spacer()
            
            Text("\(currentPage) / \(totalPages)")
                .font(.title2)
            
            Spacer()
            
            Button {
                currentPage += 1
            } label: {
                Image(systemName: K.Icons.nextPage)
            }
            .disabled(currentPage == totalPages)
            
            Spacer()
        }
        .font(.title)
    }
}


#Preview {
    PageNavigator(currentPage: .constant(2), totalPages: .constant(100))
}
