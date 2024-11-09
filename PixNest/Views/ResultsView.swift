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
    
    @State private var imagesLoader = ImagesLoader()
    @State private var images = [UIImage]()
    
    @AppStorage("gridSize") var gridSize: GridSize = .standard
    
    var body: some View {
        VStack {
            Spacer()
            if !imagesLoader.loadingIsComplete {
                LoadingView()
            } else {
                GeometryReader { proxy in
                    VStack {
                        if searchViewModel.searchResults.results.isEmpty {
                            ContentUnavailableView.search
                            
                        } else {
                            ImagesGrid(images: $images, gridSize: $gridSize, screen: proxy.size, isShowingFavs: false) { int in
                                searchViewModel.selectedImage = searchViewModel.searchResults.results[int]
                                path.append(.fullscreen)
                            } deleteAction: { _ in
                                return
                            } downloadAction: { _ in
                                return
                            }
                        }
                    }
                }
            }
            Spacer()
            
            PageNavigator(currentPage: $searchViewModel.pageNumber, totalPages: $searchViewModel.searchResults.totalPages)
                .padding()
        }
        .navigationTitle(searchViewModel.searchKeyword.capitalized)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            imagesLoader.loadingIsComplete = false
            
            searchViewModel.searchResults =  await searchViewModel.fetchImages(searchKey: searchViewModel.searchKeyword)
            let (loadedImages, isComplete) = await imagesLoader.loadAPIImages(from: searchViewModel.searchResults.results)
            
            images = loadedImages
            imagesLoader.loadingIsComplete = isComplete
        }
        .onChange(of: searchViewModel.pageNumber) { oldValue, newValue in
            Task {
                imagesLoader.loadingIsComplete = false
                
                searchViewModel.searchResults =  await searchViewModel.fetchImages(searchKey: searchViewModel.searchKeyword)
                let (loadedImages, isComplete) = await imagesLoader.loadAPIImages(from: searchViewModel.searchResults.results)
                
                images = loadedImages
                imagesLoader.loadingIsComplete = isComplete
            }
        }
        .onChange(of: searchViewModel.sortType) { oldValue, newValue in
            print("sort: \(newValue)")
            if searchViewModel.pageNumber > 1 {
                searchViewModel.pageNumber = 1
            } else {
                Task {
                    imagesLoader.loadingIsComplete = false
                    
                    searchViewModel.searchResults =  await searchViewModel.fetchImages(searchKey: searchViewModel.searchKeyword)
                    let (loadedImages, isComplete) = await imagesLoader.loadAPIImages(from: searchViewModel.searchResults.results)
                    
                    images = loadedImages
                    imagesLoader.loadingIsComplete = isComplete
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
                        Image(systemName: "square.grid.3x3")
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
