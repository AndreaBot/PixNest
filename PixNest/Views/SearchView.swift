//
//  ContentView.swift
//  PixNest
//
//  Created by Andrea Bottino on 26/10/2024.
//

import SwiftUI

struct SearchView: View {
    
    @Environment(\.coreDataManager) var coreDataManager
    
    @State private var searchViewModel = SearchViewModel()
    @State private var path = [NavigationScreens]()
    
    @State private var showingFavs = false
    
    var body: some View {
        NavigationStack(path: $path) {
            GeometryReader { proxy in
                VStack {
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
                            FullscreenView(searchViewModel: $searchViewModel, imageResult: selectedImage)
                        }
                        
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        Button {
                            showingFavs.toggle()
                        } label: {
                            Image(systemName: K.Icons.favourites)
                        }
                    }
                }
                .fullScreenCover(isPresented: $showingFavs) {
                    FavouritesView(searchViewModel: $searchViewModel)
                }
            }
        }
    }
}

#Preview {
    SearchView()
}
