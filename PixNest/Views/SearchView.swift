//
//  ContentView.swift
//  PixNest
//
//  Created by Andrea Bottino on 26/10/2024.
//

import SwiftUI

struct SearchView: View {
    
    @State private var searchViewModel = SearchViewModel()
    @State private var path = [NavigationScreens]()
    
    var body: some View {
        NavigationStack(path: $path) {
            GeometryReader { proxy in
                VStack {
                    SearchBar(searchKeyword: $searchViewModel.searchKeyword) { keyword in
                        searchViewModel.searchResults =  await searchViewModel.fetchImages(searchKey: keyword)
                    }
                    
                    Spacer()
                    
                    CategorySelection(searchViewModel: $searchViewModel, screenWidth: proxy.size.width)
                    
                    Spacer()
                }
                .padding(20)
                .navigationTitle(K.General.appName)
                .navigationDestination(for: NavigationScreens.self) { screen in
                    switch screen {
                    case .resultsView :
                        ResultsView(searchViewModel: $searchViewModel)
                    }
                }
                .onChange(of: searchViewModel.searchKeyword) { oldValue, newValue in
                    path.append(.resultsView)
                }
            }
        }
    }
}

#Preview {
    SearchView()
}
