//
//  CategorySelection.swift
//  PixNest
//
//  Created by Andrea Bottino on 26/10/2024.
//

import SwiftUI

struct CategorySelection: View {
    
    @Binding var searchViewModel: SearchViewModel
    let screenWidth: CGFloat
    let searchAction: () -> Void
    
    var body: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: screenWidth/3))]) {
            ForEach(K.General.allCategories.indices, id: \.self) { index in
                Button {
                    searchViewModel.searchKeyword = K.General.allCategories[index].keyword
                    searchAction()
                } label: {
                    ZStack {
                        Image(K.General.allCategories[index].asset)
                            .resizable()
                            .scaledToFill()
                            .frame(width: screenWidth / 2.5, height: screenWidth / 4)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                        
                        Text(K.General.allCategories[index].name)
                            .font(.title)
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                    }
                }
            }
        }
    }
}

#Preview {
    CategorySelection(searchViewModel: .constant(SearchViewModel()), screenWidth: 400) {
        print("Navigate to ResultsView")
    }
}
