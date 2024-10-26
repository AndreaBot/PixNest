//
//  ResultsView.swift
//  PixNest
//
//  Created by Andrea Bottino on 26/10/2024.
//

import SwiftUI

struct ResultsView: View {
    
    @Binding var searchViewModel: SearchViewModel
    @State private var images = [Image]()
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                if searchViewModel.searchResults.results.isEmpty {
                    ContentUnavailableView.search
                    
                } else {
                    
                    ImagesGrid(searchViewModel: $searchViewModel, screen: proxy.size, images: $images)
                    
                    Spacer()
                    
                    PageNavigator(currentPage: $searchViewModel.pageNumber, totalPages: $searchViewModel.searchResults.total_pages)
                }
                
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
        }
    }
    
    func loadImages() async {
        images = [Image]()
        searchViewModel.searchResults =  await searchViewModel.fetchImages(searchKey: searchViewModel.searchKeyword)
        for result in searchViewModel.searchResults.results {
            if let imageData =  await searchViewModel.loadImage(urlString: result.urls.small) {
                let UIImage = UIImage(data: imageData)
                images.append(Image(uiImage: UIImage!))
            }
        }
    }
}

//#Preview {
//    ResultsView(searchViewModel: .constant(SearchViewModel()))
//}
