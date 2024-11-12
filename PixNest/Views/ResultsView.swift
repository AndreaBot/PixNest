//
//  ResultsView.swift
//  PixNest
//
//  Created by Andrea Bottino on 26/10/2024.
//

import SwiftUI

struct ResultsView: View {
    
    @Binding var searchViewModel: SearchViewModel
    @Binding var path: [NavigationScreens]
    
    @State private var images = [UIImage]()
    
    @AppStorage("gridSize") var gridSize: GridSize = .standard
    
    var body: some View {
        VStack {
            switch searchViewModel.imagesLoader.loadingState {
                
            case .noResults:
                ContentUnavailableView.search
                
            case .loading:
                VStack {
                    Spacer()
                    LoadingView()
                    Spacer()
                }
                
            case .loaded:
                VStack {
                    GeometryReader { proxy in
                        ImagesGrid(images: $images, gridSize: $gridSize, screen: proxy.size, isShowingFavs: false) { int in
                            searchViewModel.selectedImage = searchViewModel.searchResults.results[int]
                            path.append(.fullscreen)
                        } deleteAction: { _ in
                            return
                        } downloadAction: { _ in
                            return
                        }
                    }
                    Spacer()
                }
            }
            
            if searchViewModel.imagesLoader.loadingState != .noResults {
                PageNavigator(currentPage: $searchViewModel.pageNumber, totalPages: $searchViewModel.searchResults.totalPages)
                    .padding()
            }
        }
        .navigationTitle(searchViewModel.searchKeyword.capitalized)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            searchViewModel.searchResults = await searchViewModel.fetchImages(searchKey: searchViewModel.searchKeyword, URLSessionProvider: URLSession.shared)
        }
        .onChange(of: searchViewModel.pageNumber) { oldValue, newValue in
            Task {
                searchViewModel.searchResults = await searchViewModel.fetchImages(searchKey: searchViewModel.searchKeyword, URLSessionProvider: URLSession.shared)
            }
        }
        .onChange(of: searchViewModel.sortType) { oldValue, newValue in
            if searchViewModel.pageNumber > 1 {
                searchViewModel.pageNumber = 1
            } else {
                Task {
                    searchViewModel.searchResults = await searchViewModel.fetchImages(searchKey: searchViewModel.searchKeyword, URLSessionProvider: URLSession.shared)
                }
            }
        }
        .onChange(of: searchViewModel.searchResults.results) { oldValue, newValue in
            if !searchViewModel.searchResults.results.isEmpty {
                Task {
                    images = await searchViewModel.imagesLoader.loadAPIImages(from: searchViewModel.searchResults.results)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                HStack {
                    Menu {
                        Picker("", selection: $gridSize.animation()) {
                            ForEach(GridSize.allCases, id: \.self) {
                                Text("\($0.rawValue.capitalized) grid")
                            }
                        }
                    } label: {
                        Image(systemName: K.Icons.gridSelection)
                    }
                    Menu {
                        Picker("sort by", selection: $searchViewModel.sortType) {
                            ForEach(SortType.allCases, id:\.self) {
                                Text("\($0.displayName) first")
                            }
                        }
                    }  label: {
                        Image(systemName: K.Icons.sort)
                    }
                }
            }
        }
    }
}

#Preview {
    ResultsView(searchViewModel: .constant(SearchViewModel()), path: .constant([NavigationScreens]()))
}
