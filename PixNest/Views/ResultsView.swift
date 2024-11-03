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
    
    var body: some View {
        VStack {
            Spacer()
            if !searchViewModel.hasLoadedImages {
                LoadingView()
            } else {
                GeometryReader { proxy in
                    VStack {
                        if searchViewModel.searchResults.results.isEmpty {
                            ContentUnavailableView.search
                            
                        } else {
                            ImagesGrid(searchViewModel: $searchViewModel, images: $images, screen: proxy.size, isShowingFavs: false) { int in
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
            
            PageNavigator(currentPage: $searchViewModel.pageNumber, totalPages: $searchViewModel.searchResults.total_pages)
                .padding()
        }
        .navigationTitle(searchViewModel.searchKeyword.capitalized)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await loadImages()
        }
        .onChange(of: searchViewModel.pageNumber) { oldValue, newValue in
            Task {
                await loadImages()
            }
        }
        .onChange(of: searchViewModel.sortType) { oldValue, newValue in
            if searchViewModel.pageNumber > 1 {
                searchViewModel.pageNumber = 1
            } else {
                Task {
                    await loadImages()
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Menu {
                    VStack {
                        Picker("sort by", selection: $searchViewModel.sortType) {
                            ForEach(SortType.allCases, id:\.self) {
                                Text("\($0.rawValue) first")
                            }
                        }
                    }
                }  label: {
                    Image(systemName: K.Icons.sort)
                }
            }
        }
    }
    
    func loadImages() async {
        searchViewModel.hasLoadedImages = false
        images = []
        searchViewModel.searchResults =  await searchViewModel.fetchImages(searchKey: searchViewModel.searchKeyword)
        for result in searchViewModel.searchResults.results {
            if let imageData =  await searchViewModel.loadImage(urlString: result.urls.small) {
                let UIImage = UIImage(data: imageData)
                images.append(UIImage!)
                //                images.append(Image(uiImage: UIImage!))
            }
        }
        searchViewModel.hasLoadedImages = true
    }
}

#Preview {
    ResultsView(searchViewModel: .constant(SearchViewModel()), path: .constant([NavigationScreens]()))
}
