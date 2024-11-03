//
//  SearchBar.swift
//  PixNest
//
//  Created by Andrea Bottino on 26/10/2024.
//

import SwiftUI

struct SearchBar: View {
    
    @Binding var searchKeyword: String
    let searchAction: () -> Void
    
    var body: some View {
        HStack {
            TextField("Search", text: $searchKeyword, prompt: Text("What are you looking for?"))
            Button {
                guard !searchKeyword.isEmpty else { return }
                searchAction()
            } label: {
                Image(systemName: K.Icons.search)
                    .font(.title)
            }
        }
        .onSubmit {
            searchAction()
        }
    }
}

#Preview {
    SearchBar(searchKeyword: .constant("keyword")) {
        print("Navigate to ResultsView")
    }
    
}
