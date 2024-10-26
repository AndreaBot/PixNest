//
//  SearchBar.swift
//  PixNest
//
//  Created by Andrea Bottino on 26/10/2024.
//

import SwiftUI

struct SearchBar: View {
    
    @Binding var searchKeyword: String
    let searchAction: (String) async -> Void
    
    var body: some View {
        HStack {
            TextField("Search", text: $searchKeyword, prompt: Text("What are you looking for?"))
            Button {
                Task {
                  await searchAction(searchKeyword)
                }
            } label: {
                Image(systemName: K.Icons.search)
                    .font(.title)
            }
        }
    }
}

#Preview {
    SearchBar(searchKeyword: .constant("keyword")) { keyword in
        print(keyword)
    }
}
