//
//  ContentView.swift
//  PixNest
//
//  Created by Andrea Bottino on 26/10/2024.
//

import SwiftUI

struct SearchView: View {
    
    @State private var searchViewModel = SearchViewModel()
    
    var body: some View {
        NavigationStack {
            GeometryReader { proxy in
                VStack {
                    SearchBar(searchKeyword: $searchViewModel.searchKeyword) { keyword in
                        print(keyword)
                    }
                    
                    Spacer()
                    
                    CategorySelection(searchViewModel: $searchViewModel, screenWidth: proxy.size.width)
                    
                    Spacer()
                }
                .padding(20)
                .navigationTitle(K.General.appName)
                .onChange(of: searchViewModel.searchKeyword) { oldValue, newValue in
                    print(newValue)
                }
            }
        }
    }
}

#Preview {
    SearchView()
}
