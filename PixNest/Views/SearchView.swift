//
//  ContentView.swift
//  PixNest
//
//  Created by Andrea Bottino on 26/10/2024.
//

import SwiftUI

struct SearchView: View {
    
    @Binding var searchViewModel: SearchViewModel
    @State private var path = [NavigationScreens]()
    
    var body: some View {
        NavigationStack(path: $path) {
            GeometryReader { proxy in
                VStack {
                    Spacer()
                    
                    SearchBar(searchKeyword: $searchViewModel.searchKeyword) {
                        path.append(.resultsView)
                    }
                    Spacer()
                    
                    CategorySelection(searchViewModel: $searchViewModel, screenWidth: proxy.size.width) {
                        path.append(.resultsView)
                    }
                    
                    Spacer()
                }
                .padding(20)
                .navigationTitle(K.General.appName)
                .onAppear {
                    searchViewModel.searchKeyword = ""
                    searchViewModel.pageNumber = 1
                }
                .navigationDestination(for: NavigationScreens.self) { screen in
                    switch screen {
                    case .resultsView :
                        ResultsView(searchViewModel: $searchViewModel, path: $path)
                    case .fullscreen:
                        if let selectedImage = searchViewModel.selectedImage {
                            FullscreenView(imageResult: selectedImage)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    SearchView(searchViewModel: .constant(SearchViewModel()))
}
